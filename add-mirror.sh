#!/bin/sh
## mirrors a nixpkgs url like mirror: , http:, ftp: to archive.org
# usage: add-mirror.sh URL [ITEM-IDENTIFIER]

set -euf
. $(command -v slog.sh)

if test ! -e $HOME/.config/ia.conf ;then
  error "please run 'ia configure' first"
  exit 1
fi

p=$(nix-prefetch-url --print-path ${1?please provide url to mirror}| tail -n1)
ident=${2:-nixos-stockholm-tarballs}
base=$(basename $p)

if ia list $ident | grep "^$base$"; then
  info "$base already mirrored"
else
  ia upload $ident $p --retries=10 || error "$base upload failed to $ident"
fi

echo "https://archive.org/download/$ident/$base"
