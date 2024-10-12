{ config, lib, pkgs, ... }:

{
  imports = [
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/t490"
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices = {
      "nix".device = "/dev/disk/by-uuid/a88a6abe-97ff-4f72-92ba-40676f5d174b";
      "swap".device = "/dev/disk/by-uuid/38433505-b8f6-403f-b99c-e75893fb57cd";
    };
    kernelPackages = pkgs.linuxPackages_zen;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
  };

  documentation.man.man-db.enable = true;

  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      gwenview
      kate
      konsole
      kwrited
      plasma-browser-integration
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/sanguine/.steam/root/compatibilitytools.d";
    };
    systemPackages = with pkgs; [
      bottles
      discord
      haruna
      heroic
      kdePackages.koko
      keepassxc
      lutris
      protonup
      sameboy
      spotify
      wezterm
      wine
      xclicker
      xdg-desktop-portal-hyprland
    ];
  };

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    steam-hardware.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
  networking = {
    hostName = "APOLLO";
    networkmanager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    gamemode.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    nano.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    steam = {
      enable = true;
      extest.enable = true;
      gamescopeSession.enable = true;
    };
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableBashCompletion = true;
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    flatpak.enable = true;
    fprintd.enable = true;
    mullvad-vpn.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    xserver = {
      # libinput.enable = true;
      xkb = {
        layout = "us";
        options = "eurosign:e,caps:escape";
        variant = "";
      };
    };
  };

  time.timeZone = "America/New_York";

  users = {
    defaultUserShell = pkgs.zsh;
    users.sanguine = {
      isNormalUser = true;
      description = "Sanguine";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        atuin
        bat
        btop
        bun
        clang
        dust
        efibootmgr
        evcxr
        fastfetch
        fzf
        git
        gh
        gnumake
        go
        gopls
        kitty
        lazygit
        lsd
        lua
        lunarvim
        nodejs_22
        nvtopPackages.intel
        pkg-config
        python312
        python312Packages.pynvim
        ruff
        rustup
        ripgrep
        starship
        tealdeer
        tk
        tree-sitter
        wasm-pack
        yt-dlp
        zellij
        zoxide

        audacity
        brave
        ferium
        handbrake
        kdePackages.partitionmanager
        obsidian
        sqlitebrowser
        starsector
        usbutils
        vscodium
      ];
    };
    users.wickedlee = {
      isNormalUser = true;
      description = "Lee";
      extraGroups = [ "networkmanager" ];
      packages = with pkgs; [
        chromium 
      ];
    };
  };

  virtualisation.virtualbox.host.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      rebootWindow = { lower = "03:00"; upper = "05:30"; };
    };
    copySystemConfiguration = true;
    stateVersion = "24.05";# Did you read the comment?
  };
}
