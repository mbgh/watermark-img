:: ABOUT:
:: This batch script is intended to create a watermark all over a given source
:: image using ImageMagick. Several parameters of the watermark can be adjusted,
:: such as size and opacity. The size of the watermark is always specified using 
:: relative values (i.e., it keeps the ratio between source images given in
:: different resolutions and the inserted watermark).

:: REQUIREMENTS:
:: - You need to have ImageMagick installed on your Windows system.
:: - A vector image representing your watermark.

:: USAGE:
:: - Create a watermark to be inserted (in vector format).
:: - Take a look at the variables below, which can be used to adjust several
::   properties of the watermark.
:: - Simply drop an image (e.g., a *.jpg) on the batch script.

:: Disable echoing commands.
@echo off

:: Path to the watermark image to be overlayed (in vector format).
set WM=watermark-full.svg

:: Width of the watermark in percent of the source image width.
set WMWIDTH=33

:: Opacity of the watermark.
set WMOP=10

:: The postfix to be used for the watermarked output image.
set POSTFIX=_wm

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Apply watermark to the image being dropped on the batch file.
set SRC=%1

:: Get the base name of the image.
FOR /F %%i IN ("%SRC%") DO set SRCBASE=%%~ni

:: Get the extension of the image.
FOR %%i IN ("%SRC%") DO set SRCEXT=%%~xi

:: Concatenate the name of the watermarked output file.
set OUT=%SRCBASE%%POSTFIX%%SRCEXT%

:: Get the resolution of the source image and compute the size of the
:: watermark. 
FOR /F "usebackq" %%L IN (`%IM%identify -format "WW=%%w\nHH=%%h\nWMWW=%%[fx:%WMWIDTH%*w/100]" %SRC%`) DO set %%L
echo Image/Watermark Information (in pixels):
echo Image Width:     %WW%
echo Image Height:    %HH%
echo Watermark Width: %WMWW%

:: First, convert the watermark (provided in vector format) into a raster image
:: and then pipe the resulting raster image to the 'composite' command in order
:: to actually overlay the watermark everywhere on the image.
convert -resize %WMWW%x%WMWW% -background none %WM% miff:- |^
composite -dissolve %WMOP% -tile - %SRC% %OUT%
