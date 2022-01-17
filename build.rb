require 'fileutils'
require './lib/snes_builder/util'
require './sparkles/program'

FileUtils.mkdir_p "out"
SnesBuilder::Util.build_program("out/sparkles.sfc", Sparkles::Program)
