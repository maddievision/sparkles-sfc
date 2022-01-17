require 'fileutils'
require './lib/snes_builder'
require './src/assembly_modules'

FileUtils.mkdir_p "out"
SnesBuilder::Builder.build_program("out/sparkles.sfc", Sparkles::AssemblyModules::Program)
