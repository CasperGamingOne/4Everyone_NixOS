{ config, lib, pkgs, ... }:
{

    services.kdeconnect.enable = true;


    programs.chromium = {
        enable = true;
        package = pkgs.brave;
    };

    # The home.packages option allows you to install Nix packages into your
    # environment.

    home.packages = with pkgs; [
        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run
        # pkgs.hello

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')

        # internet stuff
        #thunderbird
        warpinator

        # media
        vlc

        # Content Creator stuff


        # office/work/faculty stuff
        onlyoffice-desktopeditors
        octaveFull

        # gaming
        (unstable.heroic.override {
            extraPkgs = pkgs: [
                unstable.comet-gog_heroic
                unstable.gogdl
            ];
        })

        # games
        osu-lazer
        nur.repos.uriotv.vs-launcher
        prismlauncher
        beyond-all-reason
        warzone2100
        mindustry-wayland
        shattered-pixel-dungeon
        rat-king-adventure
        rkpd2
        superTux
        biplanes-revival
    ];

}
