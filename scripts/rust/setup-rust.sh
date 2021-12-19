#!/usr/bin/env bash

yay -S --noconfirm --needed rustup 
rustup install stable
rustup component add clippy llvm-tools-preview rls rust-analysis rust-src rustfmt
