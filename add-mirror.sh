#!/bin/sh
set -euf
. $(command -v slog.sh)

ident=nixos-stockholm-tarballs
p=$(nix-prefetch-url --print-path ${1?please provide url to mirror}| tail -n1)
base=$(basename $p)

if ia list $ident | grep "^$base$"; then
  info "$base already mirrored"
else
  ia upload $ident $p --retries=10 || error "$base upload failed to $ident"
fi

echo "https://archive.org/download/$ident/$base"
