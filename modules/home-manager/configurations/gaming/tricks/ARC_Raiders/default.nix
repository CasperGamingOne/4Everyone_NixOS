{ config, pkgs, ... }:
{

   home.file."ARC_Raiders" = {
        enable = true;
        target = "/.local/share/Steam/steamapps/compatdata/1808500/pfx/drive_c/users/steamuser/AppData/Local/PioneerGame/Saved/Config/WindowsClient/GameUserSettings.ini";
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/4EveryoneNixOS/modules/home-manager/configurations/gaming/tricks/ARC_Raiders/Engine.ini";
    };

}
