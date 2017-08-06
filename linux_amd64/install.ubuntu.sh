#!/bin/bash

packages=(
	"vim"
	"llvm-4.0"
	"nasm"
	"git"
)

sudo add-apt-repository universe
sudo apt-get update
sudo apt-get -y install "${packages[@]}"
