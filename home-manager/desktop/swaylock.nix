{
  config,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      bs-hl-color = "#${palette.base08}";
      inside-caps-lock-color = "#${palette.base09}";
      inside-clear-color = "#${palette.base0C}";
      inside-color = "#${palette.base01}";
      inside-ver-color = "#${palette.base09}";
      inside-wrong-color = "#${palette.base08}";
      key-hl-color = "#${palette.base0B}";
      ring-caps-lock-color = "#${palette.base02}";
      ring-clear-color = "#${palette.base0C}";
      ring-color = "#${palette.base02}";
      ring-ver-color = "#${palette.base09}";
      ring-wrong-color = "#${palette.base08}";
      separator-color = "#${palette.base02}";
      text-caps-lock-color = "#${palette.base07}";
      text-clear-color = "#${palette.base01}";
      text-color = "#${palette.base07}";
      text-ver-color = "#${palette.base01}";
      text-wrong-color = "#${palette.base01}";
    };
  };
}
