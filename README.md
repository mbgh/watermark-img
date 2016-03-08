# About

From time to time I want to add some copyright information into an image by
tagging it using a watermark under Windows operating systems. Therefore, I
decided to create some small batch scripts, which allow me do simpy drop the
images on the scripts and output a watermarked version of it. For the watermark
placed in the bottom right corner I got inspired by
[this article](http://www.xoogu.com/2013/how-to-automatically-watermark-or-batch-watermark-photos-using-imagemagick/).

# Examples

![Bottom-right watermarked image](sample-watermark-bottom_right.jpg)

# Requirements

* [ImageMagick](https://www.imagemagick.org) needs to be installed on your
  Windows operating system. Refer to
  [this website](http://imagemagick.sourceforge.net/http/www/windows.html) to
  download the ImageMagick installer and follow the instructions there.

* You need to have a watermark, which you want to be inserted into the input
  image (best in vector format such that it can be scaled arbitrarily).


# Usage

* Modify the batch script according to your needs in order to adapt the size and
  location of the watermark.

* Just drop the image (e.g., *.jpg file) onto the batch file and view the resulting output image.
