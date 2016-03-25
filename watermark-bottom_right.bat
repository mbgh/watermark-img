:: ABOUT:
:: This batch script is intended to create a watermark on the bottom right
:: corner of a given source image using ImageMagick. It can be useful to create
:: a copyright watermark in an image before publishing it, for instance, on the
:: Internet. Several parameters of the watermark can be adjusted, such as the
:: size and the offset from the bottom-right corner. The size of the watermark
:: is always specified using relative values (i.e., it keeps the ratio between
:: source images given in different resolutions and the inserted watermark). The
:: watermarked output image will be put into the same directory as the input
:: (source) image.

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

:: Width of the watermark in percent of either the original image width or the
:: original image height (depending on which of them is larger, i.e., for
:: landscape images the width and for portrait images the height is used).
set WMWIDTH=15

:: Determine the offset of the watermark from the right in percent of the
:: original image width.
set WMOFFSET=3

:: The postfix to be used for the watermarked image.
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

:: Compute the width of the watermark using larger dimension of the source image
:: (i.e., use the width if it was a landscape image and the height if it was a
:: portrait image).
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

:: Compute the offset from the bottom right. Note that for computing the offset,
:: always the width of the original image is used (and not the larger one of the
:: original image edges).
set /a WMOFF=%WMOFFSET%*%WW%/100

:: Print some information.
echo "Input Image:  %SRC%"
echo "Output Image: %OUT%"

echo "Image/Watermark Information (in pixels):"
echo "Image Width:      %WW%"
echo "Image Height:     %HH%"
echo "Watermark Width:  %WMWW%"
echo "Watermark Offset: %WMOFF%"

:: Overlay the watermark on the bottom right corner of the source image using
:: the given size of the watermark and its offset from the right edge of the
:: source image.
composite -compose atop -geometry %WMWW%x+%WMOFF% -gravity southeast -background none %WM% "%SRC%" "%OUT%"
