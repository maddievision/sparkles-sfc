# sparkles.sfc

This is a demo ROM made using a Ruby based SNES build tool I am building (included in `lib/snes_builder`).

It displays a logo and text on the screen. You can then use the D-pad to draw with a ✨ tile.

Demo ROM: https://github.com/maddievision/sparkles-sfc/releases/tag/v0.0.1

## Screen cap

![GIF of sparkles.sfc emulation](https://github.com/maddievision/sparkles-sfc/blob/main/sparkles.gif?raw=true)

## Usage

### Setup prerequisites

```
bundle init
```

### Build ROM

```
rake build
```

## Using the Builder / writing assembly modules

See `./src/assembly_modules/program.rb` as a starting point. There is also a png to 2bpp converter that's used in `./src/assembly_modules/gfx_core.rb`.

The assembly here is built with Snesasm `./lib/snesasm`. This is a DSL based assembler heavily forked from [drbig/c64](https://github.com/drbig/c64asm).

TODO: write more stuff here

## TODOs

* Add support 24-bit addressing / multiple banks to Snesasm.
* More things
