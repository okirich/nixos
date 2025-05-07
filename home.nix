{ pkgs, ... }:

{
    home.username = "kirill";
    home.homeDirectory = "/home/kirill";
    home.stateVersion = "24.11";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        htop
        neovim
    ];

    programs.bash.enable = true;

    programs.git = {
        enable = true;
        userName = "Grenader Kirill";
        userEmail = "k.grenader@yandex.ru";
    };
}
