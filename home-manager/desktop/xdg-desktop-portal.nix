{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    config.sway.default = ["wlr" "gtk"];
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
}
