require 'fileutils'
require './lib/snes_builder'
require './sparkles/program'

FileUtils.mkdir_p "out"
SnesBuilder::Builder.build_program("out/sparkles.sfc", Sparkles::Program)
