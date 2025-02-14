# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixy-desktop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  console.keyMap = "de";
  useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  # hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  services.flatpak.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.evilweasel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      kdePackages.kate
    ];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "evilweasel" = import ./home.nix;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.monaspace
  ];

  home-manager.backupFileExtension = "backup"; 
  # stylix.enable = true;
  # stylix.polarity = "dark";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  # stylix.image = ./Seras-Victoria-Hellsing.jpg;
  # stylix.fonts = {
  #   monospace = {
  #     package = pkgs.nerd-fonts.monaspace; name = "MonaspiceKr Nerd Font Mono";
  #   };
  #   sansSerif = {
  #     package = pkgs.nerd-fonts.monaspace;
  #     name = "MonaspiceNe Nerd Font";
  #   };
  #   serif = {
  #     package = pkgs.nerd-fonts.monaspace;
  #     name = "MonaspiceXe Nerd Font";
  #   };
  # };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some default programs
  programs.firefox.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.partition-manager.enable = true;
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.gnupg.agent.enable = true;

  # enables steam and some gaming programs
  # to use these, insert in launch-options in steam like this:
  # gamemoderun %command%
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    alacritty
    sl
    tree
    kitty
    google-chrome
    mangohud
    protonup
    lutris
    heroic
    bottles
    lshw-gui
    yazi
    ffmpeg
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    imagemagick
    starship
    qbittorrent
    git
    gnupg
    cowsay
    microsoft-edge
    lolcat
    wl-clipboard-rs
    vscode.fhs
    meld
    helix
    obsidian
    zellij
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/evilweasel/.steam/root/compatibilitytools.d";
    NIXOS_OZONE_WL = "1";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # nvidia settings
  services.xserver.videoDrivers = ["nvidia"];
  # nvidia settings for pascal era card
  hardware.nvidia = {
    # Modesetting required for wayland
    modesetting.enable = true;

    # No power management if possible
    powerManagement.enable = false;
    # Fine-grained power management; does only work for nvidia-open
    powerManagement.finegrained = false;

    # Open driver for turing+
    open = false;

    # Enable settings menu via `nvidia-settings`
    nvidiaSettings = true;

    # Option: select driver version manually
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

