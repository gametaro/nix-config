{config, pkgs, ...}: let
  inherit (config.colorscheme) palette;
in {
  services.mako = {
    enable = false;
    anchor = "bottom-right";
    defaultTimeout = 10000;
    backgroundColor = "#${palette.base00}dd";
    borderColor = "#${palette.base03}dd";
    textColor = "#${palette.base05}dd";
  };
  services.dunst = {
    enable = true;
    iconTheme.name = "Kora";
    iconTheme.package = pkgs.kora-icon-theme;
  };
}
