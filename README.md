# About

From time to time I need to add some copyright information into an image by
tagging it using a watermark under Windows operating systems. Therefore, I
decided to create some small batch scripts, which allow me to simply drop the
images on the scripts and output a watermarked version of them.


# Examples

Bottom-Right Watermarked Image
![Bottom-right watermarked image](examples/watermark_before_after-bottom_right_example.jpg)

Fully Watermarked Image
![Bottom-right watermarked image](examples/watermark_before_after-full_example.jpg)


# Requirements

* [ImageMagick](https://www.imagemagick.org) needs to be installed on your
  Windows operating system. Refer to
  [this website](http://imagemagick.sourceforge.net/http/www/windows.html) to
  download the installer and follow the instructions there.

* You need to have a watermark, which you want to be inserted into the input
  image (best in vector format such that it can be scaled arbitrarily).


# Usage

* Modify the batch script according to your needs in order to adapt the
  appearance of the watermark.

* Just drop the image (e.g., *.jpg file) onto the batch file and view the resulting output image.


# References

* For the watermark placed in the bottom right corner, I got inspired by
[this article](http://www.xoogu.com/2013/how-to-automatically-watermark-or-batch-watermark-photos-using-imagemagick/).
