{ inputs, lib, ... }:

let
  # Load all plugin config files from the plugins directory
  pluginFiles = builtins.readDir ./plugins;

  pluginConfigs = builtins.attrValues (
    builtins.mapAttrs (
      name: type:
      if type == "regular" && lib.hasSuffix ".nix" name then import (./plugins + "/${name}") else { }
    ) pluginFiles
  );

  deepMerge = list: builtins.foldl' (a: b: lib.recursiveUpdate a b) { } list;

in
{
  nix-config.apps.nvf = {
    home =
      { pkgs, lib, ... }:
      {
        programs.nvf = {
          settings = {
            vim = deepMerge pluginConfigs;
          };
          enable = true;
        };
      };

    tags = [
      "@ed"
      "nvim"
      "nvf"
    ];
  };

  nix-config.modules.home-manager = [
    inputs.nvf.homeManagerModules.default
  ];
}
