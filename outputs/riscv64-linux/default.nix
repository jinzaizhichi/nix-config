{
  lib,
  inputs,
  ...
} @ args: let
  inherit (inputs) haumea;

  # Contains all the flake outputs of this system architecture.
  data = haumea.lib.load {
    src = ./src;
    inputs = args;
  };
  # nix file names is redundant, so we remove it.
  dataWithoutPaths = builtins.attrValues data;

  # Merge all the machine's data into a single attribute set.
  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
    packages = lib.attrsets.mergeAttrsList (map (it: it.packages or {}) dataWithoutPaths);
    # colmena contains some meta info, which need to be merged carefully.
    colmena-meta = {
      nodeNixpkgs = lib.attrsets.mergeAttrsList (map (it: it.colmena-meta.nodeNixpkgs or {}) dataWithoutPaths);
      nodeSpecialArgs = lib.attrsets.mergeAttrsList (map (it: it.colmena-meta.nodeSpecialArgs or {}) dataWithoutPaths);
    };
    # colmena's per-machine data.
    colmena = lib.attrsets.mergeAttrsList (map (it: it.colmena or {}) dataWithoutPaths);
  };
in
  outputs
  // {
    inherit data; # for debugging purposes

    # NixOS's unit tests.
    # unit-tests = haumea.lib.loadEvalTests {
    #   src = ./tests;
    #   inputs = args;
    # };
  }
