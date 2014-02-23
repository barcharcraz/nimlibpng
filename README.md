nimlibpng
=========

nimrod wrapper for libpng

the raw C library wrapper is in png.nim, to be imported as "import png".
Functions and types are named the same as in the C version of libpng.
This library wrapper was generated from the libpng16 documentation and
tested aganst the libpng16 shared library obtained from the arch linux
extra repository. Some #define constants and structures may not be included
in this wrapper since it was generated from the libpng(3) manpage and not png.h.
If you find something missing submit an issue, or even better a pull request.
