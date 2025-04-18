#!/usr/bin/env -S just --justfile

# ----------------------------------------------------------------------------
# Module import
# ref: https://just.systems/man/en/modules1190.html
# (1) mod <module_name>
# (2) mod <module_name> '<module_path>'
# If you don't specify a module path, "just" will look for the module in the usual locations:
#   - ./${module_name}.just
#   - ./${module_name}/mod.just
#   - ./${module_name}/justfile
#   - ./${module_name}/.justfile
# ----------------------------------------------------------------------------
# zsh module imported (run "just zsh" to see the commands in this module)
mod zsh
# brew module imported (run "just brew" to see the commands in this module)
mod brew

# README command that provides how to use this repository to users and developers
default:
  @echo "Welcome to dotfiles repository!"
  @echo "This repository contains configuration files for various applications."
  @echo "---------------------------------------------------------------"
  @just --list
  @echo "---------------------------------------------------------------"
  @echo "There are 2 ways to run just recipes:"
  @echo "1. just <recipe> - Run a specific recipe. it's like Makefile experience."
  @echo "2. ./justfile <recipe> - Run a specific recipe. just can be used as an interpreter for scripts."
  @echo "---------------------------------------------------------------"
  @echo "If you want to learn more details,"
  @echo "For users: please check the README.md file in the root directory."
  @echo "For developers: please check the README.md file and DEVELOPMENT.md file in the root directory."
  @echo "---------------------------------------------------------------"
  @echo "Have a good time with your dotfiles!"
