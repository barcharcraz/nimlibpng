import png
proc testOwl(): bool =
  var image = Open("OwlAlpha.png")
  var header: array[0..7, int8]
  discard readBytes(image, header, 0, 8)
  var is_png = png_sig_cmp(cast[ptr cuchar](header), 0, 8)
  result = is_png == 0
when isMainModule:
  var testRes = testOwl()
  if not testRes:
    echo "FAILURE: OwlAlpha.png not detected as png"
    quit(QuitFailure)
  if testRes:
    echo "SUCCESS: OwlAlpha.png detected as png"
    quit(QuitSuccess)

