{
  lib,
  pkgs,
  ...
}:
###########################################################
#
# Kitty Configuration
#
# Useful Hot Keys for macOS:
#   1. New Tab: `command + t`
#   2. Close Tab: `command + w`
#   3. Switch Tab: `shift + command + [` | `shift + command + ]`
#   4. Increase Font Size: `command + =` | `command + +`
#   5. Decrease Font Size: `command + -` | `command + _`
#   6. And Other common shortcuts such as Copy, Paste, Cursor Move, etc.
#
# Useful Hot Keys for Linux:
#   1. New Tab: `ctrl + shift + t`
#   2. Close Tab: `ctrl + shift + q`
#   3. Switch Tab: `ctrl + shift + right` | `ctrl + shift + left`
#   4. Increase Font Size: `ctrl + shift + =` | `ctrl + shift + +`
#   5. Decrease Font Size: `ctrl + shift + -` | `ctrl + shift + _`
#   6. And Other common shortcuts such as Copy, Paste, Cursor Move, etc.
#
###########################################################
{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";  # kitty has catppuccin theme built-in
    font = {
      name = "JetBrainsMono Nerd Font";
      # use different font size on macOS
      size =
        if pkgs.stdenv.isDarwin
        then 14
        else 13;
    };

    settings =
      {
        background_opacity = "0.95";
        macos_option_as_alt = true; # Option key acts as Alt on macOS
        scrollback_lines = 10000;
        enable_audio_bell = false;
      }
      // (
        if pkgs.stdenv.isDarwin
        then {
          # macOS specific settings, force kitty to use nushell as default shell
          shell = "/run/current-system/sw/bin/nu";
        }
        else {}
      );

    # macOS specific settings
    darwinLaunchOptions = ["--start-as=fullscreen"];
  };
}
