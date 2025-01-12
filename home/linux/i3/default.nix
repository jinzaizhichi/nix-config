{pkgs, ...}: {
  # i3 window manager's config, based on https://github.com/endeavouros-team/endeavouros-i3wm-setup

  imports = [
    ./x11-apps.nix
  ];

  home.file = {
    # wallpaper, binary file
    ".config/i3/wallpaper.png".source = ../wallpapers/wallpaper.png;
    ".config/i3/config".source = ./config;
    ".config/i3/i3blocks.conf".source = ./i3blocks.conf;
    ".config/i3/scripts" = {
      source = ./scripts;
      # copy the scripts directory recursively
      recursive = true;
      executable = true; # make all scripts executable
    };
    ".config/i3/layouts" = {
      source = ./layouts;
      recursive = true;
    };

    # rofi is a application launcher and dmenu replacement
    ".config/rofi" = {
      source = ./rofi-conf;
      # copy the scripts directory recursively
      recursive = true;
    };

    ".local/bin/bright" = {
      source = ./bin/bright;
      executable = true;
    };

    # xrandr - set primary screen
    ".screenlayout/monitor.sh".source = ./dual-monitor-4k-1080p.sh;
  };

  # allow fontconfig to discover fonts and configurations installed through home.packages
  fonts.fontconfig.enable = true;

  systemd.user.sessionVariables = {
    "LIBVA_DRIVER_NAME" = "nvidia";
    "GBM_BACKEND" = "nvidia-drm";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
  };

  # set dpi for 4k monitor
  xresources.properties = {
    # dpi for Xorg's font
    "Xft.dpi" = 162;
    # or set a generic dpi
    "*.dpi" = 162;
  };

  # set Xcursor.theme & Xcursor.size in ~/.Xresources automatically
  home.pointerCursor = {
    name = "Qogir-dark";
    package = pkgs.qogir-theme;
    size = 64;
  };
}
