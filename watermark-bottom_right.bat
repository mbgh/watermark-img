:: ABOUT:
:: This batch script is intended to create a watermark on the bottom right
:: corner of an image. It can be useful to create a copyright watermark in an
:: image before publishing it on, for instance, the Internet. Independently of
:: the size of the image you want to process, the resulting watermark will
:: always be inserted using a size proportionally to the input image size (i.e.,
:: the ratio between the size of the watermark and the image will remain
:: constant). 

:: REQUIREMENTS:
:: - You need to have ImageMagick installed on your windows system.
:: - A vector image representing your watermark.

:: USAGE:
:: - Take a look at the variables below, which can be used to adjust the size as
::   well as the position of the watermark.
:: - Simply drop an image (e.g., a *.jpg) on the batch file.

:: Disable echoing commands.
@echo off

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

:: Step through all files dropped on the batch file.
FOR /F "usebackq" %%L IN (`%IM%identify -format
"WW=%%w\nHH=%%h\nWMWW=%%[fx:%WMWIDTH%*w/100]\nWMOFF=%%[fx:%WMOFFSET%*w/100]"
%SRC%`) DO set %%L
echo Image/Watermark Information (in pixels):
echo Image Width:      %WW%
echo Image Height:     %HH%
echo Watermark Width:  %WMWW%
echo Watermark Offset: %WMOFF%
composite -compose atop -geometry %WMWW%x+%WMOFF% -gravity southeast -background none ./watermark-bottom_right.svg %SRC% %OUT%
