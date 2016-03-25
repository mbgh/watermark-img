:: ABOUT:
:: This batch script is intended to create a watermark all over a given source
:: image using ImageMagick. Several parameters of the watermark can be adjusted,
:: such as size and opacity. The size of the watermark is always specified using
:: relative values (i.e., it keeps the ratio between source images given in
:: different resolutions and the inserted watermark). The watermarked output
:: image will be put into the same directory as the input (source) image.

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

:: Get the directory of the source image (including the directory).
set SRCDIR=%~dp1

:: Get the base name (file name) of the image.
set SRCBASE=%~n1

:: Get the extension of the image.
set SRCEXT=%~x1

:: Determine complete path to the source image.
set SRC=%SRCDIR%%SRCBASE%%SRCEXT%

:: Determine complete path to the output image.
set OUT=%SRCDIR%%SRCBASE%%POSTFIX%%SRCEXT%

:: Get the resolution of the source image.
FOR /F "usebackq" %%L IN (`%IM%identify -format "WW=%%w\nHH=%%h" "%SRC%"`) DO set %%L

:: Compute the width of the watermark using the larger dimension of the source
:: image (i.e., use the width if it was a landscape image and the height if it
:: was a portrait image).
IF %WW% GTR %HH% (
   :: If the width is larger than the height, use the width as a basis.
   set /a WMWW=%WMWIDTH%*%WW%/100
)

IF %HH% GTR %WW% (
   :: If the height is larger than the width, use the height as a basis.
   set /a WMWW=%WMWIDTH%*%HH%/100
)

IF %WW% == %HH% (
   :: If width and height are equal, use the width as a basis.
   set /a WMWW=%WMWIDTH%*%WW%/100
)

:: Compute the width of the watermark using the larger dimension of the source
:: image (i.e., use the width if it was a landscape image and the height if it
:: was a portrait image).
set /a WMOFF=%WMOFFSET%*%WW%/100

:: Print some information.
echo "Input Image:  %SRC%"
echo "Output Image: %OUT%"

echo "Image/Watermark Information (in pixels):"
echo "Image Width:     %WW%"
echo "Image Height:    %HH%"
echo "Watermark Width: %WMWW%"

:: First, convert the watermark (provided in vector format) into a raster image
:: and then pipe the resulting raster image to the 'composite' command in order
:: to actually overlay the watermark everywhere on the image.
convert -resize %WMWW%x%WMWW% -background none %WM% miff:- |^
composite -dissolve %WMOP% -tile - "%SRC%" "%OUT%"
