{ config, pkgs, ... }:
{

    programs.gpu-screen-recorder.enable = true;

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

    # internet stuff

    # gaming
    nur.repos.uriotv.scopebuddy
    # support both 32- and 64-bit applications
    unstable.wineWow64Packages.stable
    # wine-staging (version with experimental features)
    unstable.wineWow64Packages.staging
    # native wayland support (unstable)
    unstable.wineWow64Packages.waylandFull
    unstable.umu-launcher
    (heroic.override {
        extraPkgs = pkgs: [
            unstable.comet-gog_heroic
        ];
    })

    ];

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
        discover
    ];

}
