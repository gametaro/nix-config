{
  inputs,
  pkgs,
  neovim,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
    inputs.nur.hmModules.nur

    ./desktop

    ./editorconfig.nix
    ./git.nix
    ./ripgrep.nix
    ./shell.nix
    ./ssh.nix
    ./terminal.nix
  ];

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
        "flakes"
        "nix-command"
      ];
      auto-optimise-store = true;
      max-jobs = "auto";
      warn-dirty = false;
      substituters = [
        "https://cache.nixos.org"
        "https://myneovim.cachix.org"
        "https://pre-commit-hooks.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "myneovim.cachix.org-1:7FSPcLO1WT75pxr9qdgVIz1s0yNwy87NLgtnchDy3u0="
        "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
      ];
    };
  };

  nixpkgs = {
    # overlays = [
    #   outputs.overlays.additions
    #   outputs.overlays.modifications
    #   outputs.overlays.unstable-packages
    # ];
    # config.allowUnfree = true;
  };
  home = {
    username = "gametaro";
    homeDirectory = "/home/gametaro";

    packages = with pkgs; [
      _1password
      cachix
      curl
      fd
      jq
      killall
      libnotify
      neovim
      pavucontrol
      unzip
      wget
      xdg-utils
      (nerdfonts.override {fonts = ["Monaspace"];})
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };

    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;

    atuin.enable = true;
    jq.enable = true;
    less.enable = true;
    nix-index-database.comma.enable = true;
    starship.enable = true;
    zoxide.enable = true;
  };

  fonts.fontconfig.enable = true;
  xdg.enable = true;

  systemd.user.startServices = "sd-switch";

  colorscheme = inputs.nix-colors.colorSchemes.nord;
}
