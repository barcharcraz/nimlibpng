import png
import graphics
from sdl import PSurface
import colors
type TColorTest = object
  red: uint8
  green: uint8
  blue: uint8
  alpha: uint8
proc testOwlLoad() =
  var image = Open("SmallOwlAlpha.png")
  var pngptr: png_structp = png_create_read_struct(PNG_LIBPNG_VER_STRING, nil, nil, nil)
  if pngptr == nil:
    raise newException(EOS, "could not allocate png pointer")
  var infoptr: png_infop = png_create_info_struct(pngptr)
  if infoptr == nil:
    png_destroy_read_struct(addr pngptr, nil, nil)
    raise newException(EOS, "could not allocate png info pointer")
  png_init_io(pngptr, image)
  png_read_png(pngptr, infoptr, PNG_TRANSFORM_IDENTITY, nil)
  var height = png_get_image_height(pngptr, infoptr)
  var width = png_get_image_width(pngptr, infoptr)
  var depth = png_get_bit_depth(pngptr, infoptr)
  echo repr(depth)
  var surf = newScreenSurface(width.int, height.int)
  #echo(repr(png_get_rows(pngptr, infoptr)))
  var imagedata = png_get_rows(pngptr, infoptr)
  #echo width, height
  for i in 0..height.int - 1:
    for j in 0..width.int - 1:
      #echo($i & ":" & $j)
      var row: ptr ptr int = cast[ptr ptr int](cast[int](imagedata) + i * sizeof(pointer))
      var col: ptr int = cast[ptr int](cast[int](row[]) + j * sizeof(int))
      var color = cast[TColorTest](col[])
      surf[j,i] = rgb(color.red, color.green, color.blue)
      
  withEvents(surf, event):
    var eventp = addr event
    case event.kind:
      of SDL.QUITEV:
        break
      else:
        discard
    SDL.UpdateRect(surf.s, 0, 0, width.int32, height.int32)

when isMainModule:
  testOwlLoad()
