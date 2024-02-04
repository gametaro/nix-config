{config, ...}: {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${config.programs.swaylock.package}/bin/swaylock --daemonize";
      }
    ];
  };
}
