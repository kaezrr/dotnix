{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.enable = true;

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd niri-session";
        user = "greeter";
      };
    };
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.kaezr = {
    isNormalUser = true;
    description = "kaezr";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.fish.enable = true;
  programs.git.enable = true;
  programs.zoxide.enable = true;
  programs.bat.enable = true;
  programs.lazygit.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/kaezr/.config/nixos";
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
  };

  users.extraUsers.kaezr = {
    shell = pkgs.fish;
  };

  environment.variables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gcc
    tree-sitter
    ripgrep
    fd

    kitty
    nerd-fonts.jetbrains-mono

    fastfetch
    chezmoi
    eza

    nixd
    lua-language-server

    nixfmt
    black
    tombi
    stylua
    prettier

    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
  ];

  fonts.fontconfig.defaultFonts.monospace = [
    "JetBrainsMono Nerd Font"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";

}
