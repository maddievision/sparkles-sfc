# encoding: utf-8
# Fork of https://github.com/drbig/c64asm.
# See LICENSE.txt for licensing information.

require 'json'

module Snesasm
  # Known addressing modes
  ADDR_MODES = {
    i8: { src: ' #%s', len: 1, args: 1},
    i16: { src: ' #%s', len: 2, args: 1},
    a: { src: ' %s', len: 2, args: 1},
    al: { src: ' %s', len: 3, args: 1},
    z: { src: ' %s', len: 1, args: 1},
    zr: { src: ' (%s)', len: 1, args: 1},
    zrl: { src: ' [%s]', len: 1, args: 1},
    ax: { src: ' %s, X', len: 2, args: 1},
    alx: { src: ' %s, X', len: 3, args: 1},
    ay: { src: ' %s, Y', len: 2, args: 1},
    zx: { src: ' %s, X', len: 1, args: 1},
    zxr: { src: ' (%s, X)', len: 1, args: 1},
    zry: { src: ' (%s), Y', len: 1, args: 1},
    zrly: { src: ' [%s], Y', len: 1, args: 1},
    s: { src: ' %s, S', len: 1, args: 1},
    sry: { src: ' (%s, S), Y', len: 1, args: 1},
    n: { src: ' ', len: 0, args: 0},
    r: { src: ' %s', len: 1, args: 1},
    ar: { src: ' (%s)', len: 2, args: 1},
    axr: { src: ' (%s, X)', len: 2, args: 1},
    arl: { src: ' [%s]', len: 2, args: 1},
    mv: { src: ' %s, %s', len: 2, args: 2},
    e: { src: '', len: 0, args: 0}
  }

  OP_CODES = File.open("./lib/snesasm/op_codes.json", "rb") do |f|
    data = JSON.parse(f.read)
    data.reduce({}) do |o, (name, op)|
      modes = op.reduce({}) do |m, (mode, data)|
        m[mode.to_sym] = data.reduce({}) do |d, (k, v)|
          if k == "byte"
            d[:byte] = v.to_i(16)
          else
            d[k.to_sym] = v
          end
          d
        end
        m
      end
      o[name.to_sym] = modes
      o
    end
  end
end