:: Disable echoing commands.
@echo off

:: Apply watmark to all images dropped on batch file.
:: TODO: Currently we only support a single file dropped on the batch file.
::set SRCS=%*
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
::FOR %%a IN (%SRCS%) DO ^
echo %SRC%
FOR /F "usebackq" %%L IN (`%IM%identify -format
"WW=%%w\nHH=%%h\nWMWW=%%[fx:%WMWIDTH%*w/100]\nWMOFF=%%[fx:%WMOFFSET%*w/100]"
%SRC%`) DO set %%L
echo Image/Watermark Information (in pixels):
echo Image Width:      %WW%
echo Image Height:     %HH%
echo Watermark Width:  %WMWW%
echo Watermark Offset: %WMOFF%
composite -compose atop -geometry %WMWW%x+%WMOFF% -gravity southeast -background none ./watermark-bottom_right.svg %SRC% %OUT%

pause

:: Determine the image to be analyzed.
::set SRC=DSC_2999_pp_crop.jpg

:: Width of the watermark in percent of the original image.
rem set wmwidth=10

:: Get the width and the height from the image.
rem FOR /F "usebackq" %%L IN (`%IM%identify -format "WW=%%w\nHH=%%h\nWWwm=%%[fx:%wmwidth%w/100]" %SRC%`) DO set %%L
rem echo Width: %WW%
rem echo Height: %HH%
rem echo WM Width: %WWwm%

rem composite -compose atop -geometry %WWwm%x+75 -gravity southeast -background none ./watermark-botom_right.svg %SRC% ./photo-watermarked.jpg


rem for /f "tokens=1-2" %%i in ('identify -ping -format "%%w %%h" DSC_2128_pp:') do set W=%%i & set H=%%j
rem FOR /F %%j IN ('identify -format "%%[fx:min(w,h)*%fs%]" %1') DO SET fsize=%%j
rem echo width: %W%
rem echo height: %H%

rem convert ./DSC_2128_pp.jpg -ping -format "%w x %h" info:

rem pause

rem composite -compose atop -geometry +75 -gravity southeast ./watermark.png ./photo.jpg ./photo-watermarked.jpg
