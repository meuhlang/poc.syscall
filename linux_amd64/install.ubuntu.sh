#!/bin/bash

# vim:set ts=4 sw=4 tw=100 et:

set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

packages=(
    "vim"
    "llvm"
    "lld-4.0"
    "nasm"
    "git"
)

sudo add-apt-repository universe
sudo apt-get update
sudo apt-get -y install "${packages[@]}"
sudo update-alternatives --set editor /usr/bin/vim.basic

git clone https://github.com/meuhlang/poc.syscall.git
