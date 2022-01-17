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

## About the projct

See [src/assembly_modules/program.rb](https://github.com/maddievision/sparkles-sfc/blob/main/src/assembly_modules/program.rb) as a starting point. There is also a png to 2bpp converter that's used in [src/assembly_modules/gfx_core.rb#L76](https://github.com/maddievision/sparkles-sfc/blob/main/src/assembly_modules/gfx_core.rb#L76).

The builder is at [lib/snes_builder/builder.rb#L64](https://github.com/maddievision/sparkles-sfc/blob/main/lib/snes_builder/builder.rb#L64), but it is _super_ messy at the moment. Lots of hacky DSL stuff happening.

Under the hood, a Ruby based assembler is used, Snesasm [lib/snesasm](https://github.com/maddievision/sparkles-sfc/blob/main/lib/snesasm). This is a DSL based assembler heavily forked from [drbig/c64](https://github.com/drbig/c64asm).

Sample output of the final assembly is at [sample_output.log](https://github.com/maddievision/sparkles-sfc/blob/main/sample_output.log)

## How to use the builder

TODO: write more stuff here


## But, why?

I love Ruby and have used it a lot over the years, and I think there's a lot of potential to leverage some code generation and meta-programming. Its DSL lends to some nice syntactic sugar, though there is the downside of it being opaque and too "magical", as well as difficult to debug.

I first used c64asm to build a [NES sound driver](https://github.com/maddievision/mushroom), which became a bit of a hassle as I was trying to glue things together in a messy way.

I put together Snesasm very quickly to help with writing assembly patches for ROM hacking work, and after being heads down on this kind of work, I got inspired to try building ROMs from scratch, something I've surprisingly not really done for the SNES.

And so, I spontaneously set out to make a ROM builder that was more robust than my haphazard builder for the NES sound driver, and for utility beyond ad-hoc assembly patches and injections.

But also, why not?

## TODOs

* Add support 24-bit addressing / multiple banks to Snesasm.
* Ruby SPC-700 builder / assembler
* Some common helper macros (setting up DMA, uploading to the APU etc)
* More things
