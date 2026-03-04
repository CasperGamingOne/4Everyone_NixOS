{ config, pkgs, ... }:
{

    home.file."S.T.A.L.K.E.R.2." = {
        enable = true;
        target = "/.local/share/Steam/steamapps/compatdata/1643320/pfx/drive_c/users/steamuser/AppData/Local/Stalker2/Saved/Config/Windows/Engine.ini";
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/4EveryoneNixOS/modules/home-manager/configurations/gaming/tricks/stalker2/Engine.ini";
    };

}
