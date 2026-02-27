{ config, pkgs, inputs, ... }:
{
    imports = [ inputs.flatpaks.homeManagerModules.nix-flatpak ];

    services.flatpak.packages = [
        # system + gaming tools
        "it.mijorus.gearlever"
        "com.vysp3r.ProtonPlus"
        "io.github.rfrench3.scopebuddy-gui"

        # internet
        "com.rustdesk.RustDesk"

        # communications
        "com.github.IsmaelMartinez.teams_for_linux"
        "com.ktechpit.whatsie"
        "org.equicord.equibop"

        # media
        "app.grayjay.Grayjay"
        "dev.dergs.Tonearm"
        "com.stremio.Stremio"

        #games
        "org.vinegarhq.Sober"
        "io.github.openhv.OpenHV"
        "com.revolutionarygamesstudio.ThriveLauncher"
        "com.moddb.TotalChaos"
    ];

}
