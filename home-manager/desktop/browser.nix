{
  pkgs,
  config,
  ...
}: {
  programs = {
    chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = ["--ozone-platform-hint=wayland"];
      extensions = [
        # uBlock Origin
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";}
        # 1Password Nightly
        {id = "gejiddohjgogedgjnonbofjigllpkmbf";}
        # Dark Reader
        {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";}
      ];
    };
    firefox = {
      enable = true;
      profiles = {
        default = {
          extensions = with config.nur.repos.rycee.firefox-addons; [
            darkreader
            onepassword-password-manager
            ublock-origin
          ];
          search = {
            default = "DuckDuckGo";
            force = true;
            privateDefault = "DuckDuckGo";
          };
          settings = {
            "browser.search.region" = "en-US";
            "distribution.searchplugins.defaultLocale" = "en-US";
            "general.useragent.locale" = "en-US";
          };
        };
      };
    };
  };
}
