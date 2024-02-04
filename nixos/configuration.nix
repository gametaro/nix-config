{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    ./hardware-configuration.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "gametaro";
    wslConf.network.hostname = "barling";
    wslConf.interop.appendWindowsPath = false;
    interop.includePath = false;
    useWindowsDriver = true;
    usbip.enable = true;
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
  };
  nix = {
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = ["/etc/nix/path"];
    settings = {
      auto-optimise-store = true;
      experimental-features = ["auto-allocate-uids" "cgroups" "flakes" "nix-command"];
      trusted-users = [ "root" "gametaro" ];
    };
  };
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  users.users = {
    gametaro = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.bash;
    };
  };

  programs.dconf.enable = true;
  services.automatic-timezoned.enable = true;
  security.polkit.enable = true;

  system.stateVersion = "23.11";
}
