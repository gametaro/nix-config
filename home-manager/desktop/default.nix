{pkgs, ...}: {
  imports = [
    ./browser.nix
    ./gtk.nix
    ./i18n.nix
    ./mako.nix
    ./qt.nix
    ./sway.nix
    # ./swayidle.nix
    # ./swaylock.nix
    # ./swayr.nix
    ./waybar.nix
    ./xdg-desktop-portal.nix
  ];

  home = {
    packages = with pkgs; [
      wl-clipboard

      noto-fonts
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      font-awesome

      _1password-gui
    ];

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };
  };
  programs.wofi.enable = true;
  services = {
    cliphist.enable = true;
    swayosd.enable = true;
  };
}
