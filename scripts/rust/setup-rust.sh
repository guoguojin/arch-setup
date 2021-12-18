#!/usr/bin/env bash

rustup install stable
rustup component add clippy llvm-tools-preview rls rust-analysis rust-src rustfmt
