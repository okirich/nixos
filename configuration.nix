{ config, pkgs, inputs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot.loader.grub = {
            enable = true;
            efiSupport = true;
            efiInstallAsRemovable = true;
        }; 

    networking = {
        hostName = "home";
        networkmanager.enable = true;
    };

    services = {
            openssh = {
                enable = true;
                settings = {
                    PermitRootLogin = "yes";
                    PasswordAuthentication = true;
                };
            };
    };

    time.timeZone = "Europe/Moscow";

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    users.users.kirill = {
                isNormalUser = true;
                home = "/home/kirill";
                extraGroups = [ "wheel" "networkmanager" ];
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia.modesetting.enable = true;

    
    environment.systemPackages = with pkgs; 
    let
        customVim = pkgs.vim_configurable.customize {
            name = "vim";
            vimrcConfig = {
            customRC = ''
                set relativenumber
                set tabstop=4
                set shiftwidth=4
                set expandtab
                set smartindent
                set autoindent
                syntax on
                '';
            };
        };
    in
    [
        customVim
        git
        wget
        curl
        tree
    ];

    environment.variables.EDITOR = "vim";

    system.stateVersion = "24.11";
}
