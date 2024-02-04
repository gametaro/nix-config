{
  config,
  lib,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  wayland.windowManager.sway = {
    enable = true;
    extraOptions = ["--unsupported-gpu"];
    swaynag.enable = true;
    systemd.enable = true;
    wrapperFeatures.gtk = true;
    config = {
      input = {
        "*" = {
          repeat_delay = "250";
          repeat_rate = "50";
        };
      };
      # bars = [];
      menu = "pkill wofi || wofi --show drun";
      terminal = "kitty";
      seat = {
        "*" = {
          hide_cursor = "when-typing enable";
        };
      };
      startup = [
        {
          command = "kitty";
        }
      ];
      modifier = "Mod1";
      # keybindings = lib.mkOptionDefault {
      #   "${modifier}+space" = "exec swayr switch-window";
      #   "${modifier}+c" = "exec swayr execute-swaymsg-command";
      #   "${modifier}+Tab" = "exec swayr switch-to-urgent-or-lru-window";
      #   "${modifier}+Shift+space" = "exec swayr switch-workspace-or-window";
      #   "${modifier}+Shift+c" = "exec swayr execute-swayr-command";
      # };
      workspaceAutoBackAndForth = true;
      # colors = {
      #   focused = {
      #     border = "${palette.base0C}";
      #     background = "${palette.base00}";
      #     text = "${palette.base05}";
      #     indicator = "${palette.base09}";
      #     childBorder = "${palette.base0C}";
      #   };
      #   focusedInactive = {
      #     border = "${palette.base03}";
      #     background = "${palette.base00}";
      #     text = "${palette.base04}";
      #     indicator = "${palette.base03}";
      #     childBorder = "${palette.base03}";
      #   };
      #   unfocused = {
      #     border = "${palette.base02}";
      #     background = "${palette.base00}";
      #     text = "${palette.base03}";
      #     indicator = "${palette.base02}";
      #     childBorder = "${palette.base02}";
      #   };
      #   urgent = {
      #     border = "${palette.base09}";
      #     background = "${palette.base00}";
      #     text = "${palette.base03}";
      #     indicator = "${palette.base09}";
      #     childBorder = "${palette.base09}";
      #   };
      # };
    };
  };
}
