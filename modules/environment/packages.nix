{ config, pkgs, ... }:
{

    programs.gpu-screen-recorder.enable = true;

    programs.gnome-disks.enable = true;

    programs.appimage = {
        enable = true;
        binfmt = true;
        package = pkgs.stable.appimage-run.override
        {
            extraPkgs = pkgs: with pkgs.stable;
            [
                pkgs.squashfsTools
                pkgs.dwarfs
            ];
        };
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [

    # system shit
    unstable.fresh-editor
    stable.displaylink
    stable.rtkit
    stable.macchina
    stable.cpufetch
    stable.btop
    stable.bat
    stable.mission-center
    unstable.auto-cpufreq

    # internet stuff
    stable.arrpc

    # gaming
    # support both 32- and 64-bit applications
    unstable.wineWow64Packages.stable
    # wine-staging (version with experimental features)
    unstable.wineWow64Packages.staging
    (heroic.override {
        extraPkgs = pkgs: [
            unstable.gamescope
            unstable.comet-gog_heroic
        ];
    })

    ];

}
