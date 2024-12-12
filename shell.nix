{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
mkShell {
  name = "ime.nvim";
  buildInputs = [
    gobject-introspection
    stdenv.cc
    pkg-config

    (luajit.withPackages (
      p: with p; [
        busted
        ldoc
      ]
    ))
  ];
}
