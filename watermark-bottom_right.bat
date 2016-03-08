:: Disable echoing commands.
@echo off

:: Apply watmark to all images dropped on batch file.
set SRC=%1

:: Width of the watermark in percent of the original image width.
set WMWIDTH=15

:: Determine the offset of the watermark from the right in percent of the
:: original image width.
set WMOFFSET=3

:: The postfix to be used for the watermarked image.
set POSTFIX=_wm

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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
