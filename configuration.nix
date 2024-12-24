{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.alacritty pkgs.vim pkgs.zoxide pkgs.tmux ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  security.pam.enableSudoTouchIdAuth = true;

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "discord"
      "visual-studio-code"
      "iterm2"
      "rectangle"
      "kicad"
      "mullvadvpn"
      "signal"
      "element"
      "1password"
      "google-chrome"
      "stats"
      "bluesnooze"
    ];
    # onActivation.cleenup = "zap"; 
    masApps = {
      Tailscale = 1475387142; # App Store URL id
      Wireguard = 1451685025;
    };
  };
}