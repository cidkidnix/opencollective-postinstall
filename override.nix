{ pkgs ? import <nixpkgs> { }
, system ? builtins.currentSystem
, nodejs ? pkgs.nodejs-18_x
}:

let
  nodePackages = import ./default.nix {
    inherit pkgs system;
    nodejs = pkgs.nodejs-18_x;
  };
in
nodePackages // {
  nodeDependencies = nodePackages.nodeDependencies.overrideAttrs (old: {
    nativeBuildInputs = with pkgs; [
      pkg-config
    ];
    buildInputs = (old.buildInputs or [ ]) ++ [
      pkgs.nodePackages.node-gyp-build
      pkgs.nodePackages.node-pre-gyp
      pkgs.pixman
      pkgs.cairo
      pkgs.pango
    ];
  });

  package = nodePackages.package.overrideAttrs (old: {
    nativeBuildInputs = with pkgs; [
      pkg-config
    ];
    buildInputs = (old.buildInputs or [ ]) ++ [
      pkgs.nodePackages.node-gyp-build
      pkgs.nodePackages.node-pre-gyp
      pkgs.pixman
      pkgs.cairo
      pkgs.pango
    ];
  });
}
