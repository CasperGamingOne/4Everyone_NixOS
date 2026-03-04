{ config, pkgs, ... }:
{

    programs.gpu-screen-recorder = {
        enable = true;
        package = pkgs.unstable.gpu-screen-recorder;
    };

    programs.gnome-disks.enable = true;

    programs.appimage = {
        enable = true;
        binfmt = true;
    };
    
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [

    # system shit
    unstable.fresh-editor
    displaylink
    macchina
    cpufetch
    btop
    usbutils
    bat
    mission-center
    nixpkgs-review

    # internet + communications stuff

    # Content Creator stuff
    unstable.gpu-screen-recorder-gtk

    # gaming
    nur.repos.uriotv.scopebuddy
    # support both 32- and 64-bit applications
    unstable.wineWow64Packages.stable
    # wine-staging (version with experimental features)
    unstable.wineWow64Packages.staging
    # native wayland support (unstable)
    unstable.wineWow64Packages.waylandFull
    unstable.umu-launcher

    ];

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
        discover
    ];

}
