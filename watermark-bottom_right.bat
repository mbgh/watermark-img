:: ABOUT:
:: This batch script is intended to create a watermark on the bottom right
:: corner of a given source image using ImageMagick. It can be useful to create
:: a copyright watermark in an image before publishing it, for instance, on the
:: Internet. Several parameters of the watermark can be adjusted, such as the
:: size and the offset from the bottom-right corner. The size of the watermark
:: is always specified using relative values (i.e., it keeps the ratio between
:: source images given in different resolutions and the inserted watermark).

:: REQUIREMENTS:
:: - You need to have ImageMagick installed on your windows system.
:: - A vector image representing your watermark.

:: USAGE:
:: - Create a watermark to be inserted (in vector format).
:: - Take a look at the variables below, which can be used to adjust several
::   properties of the watermark.
:: - Simply drop an image (e.g., a *.jpg) on the batch script.

:: Disable echoing commands.
@echo off

:: Path to the watermark image to be overlayed (in vector format).
set WM=watermark-bottom_right.svg

:: Width of the watermark in percent of the original image width.
set WMWIDTH=15

:: Determine the offset of the watermark from the right in percent of the
:: original image width.
set WMOFFSET=3

:: The postfix to be used for the watermarked image.
set POSTFIX=_wm

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Apply watmark to the image being dropped on the batch file.
set SRC=%1

:: Get the base name of the image.
FOR /F %%i IN ("%SRC%") DO set SRCBASE=%%~ni

:: Get the extension of the image.
FOR %%i IN ("%SRC%") DO set SRCEXT=%%~xi

:: Concatenate the name of the watermarked output file.
set OUT=%SRCBASE%%POSTFIX%%SRCEXT%

:: Get the resolution of the source image and compute the size of the
:: watermark. 
FOR /F "usebackq" %%L IN (`%IM%identify -format "WW=%%w\nHH=%%h\nWMWW=%%[fx:%WMWIDTH%*w/100]\nWMOFF=%%[fx:%WMOFFSET%*w/100]" %SRC%`) DO set %%L
echo Image/Watermark Information (in pixels):
echo Image Width:      %WW%
echo Image Height:     %HH%
echo Watermark Width:  %WMWW%
echo Watermark Offset: %WMOFF%

:: Overlay the watermark on the bottom right corner of the source image using
:: the given size of the watermark and its offset from the right edge of the
:: source image.
composite -compose atop -geometry %WMWW%x+%WMOFF% -gravity southeast -background none %WM% %SRC% %OUT%
