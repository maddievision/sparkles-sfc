require 'chunky_png'
require 'bin_tools'

module PngConvert
  COLORS = [
    "000000FF",
    "404040FF",
    "808080FF",
    "FFFFFFFF",
  ]
  
  def self.convert_to_2bpp in_file
    fontimg = ChunkyPNG::Image.from_file(in_file)
    raise "Image must have width 128x128" unless fontimg.dimension.width == 128
    raise "Image must have height in multiple of 8" unless (fontimg.dimension.height % 8) == 0
  
    bytes = ""
    (0...(fontimg.dimension.height / 8)).each do |ny|
      (0..15).each do |nx|
        bx = nx * 8
        by = ny * 8
  
        (0..7).each do |ty|
          p1 = 0
          p2 = 0
          (0..7).each do |tx|
            ix = bx + tx
            iy = by + ty
            cidx = COLORS.index("%08X" % fontimg[ix, iy])
            p1 |= (cidx & 1) << (7-tx)
            p2 |= (cidx & 2) >> 1 << (7-tx)
          end
          bytes += p1.chr
          bytes += p2.chr
        end
      end
    end
    bytes
  end
end
