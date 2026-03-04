{ config, pkgs, ... }:
{

    home.file."The_Finals" = {
        enable = true;
        target = "/.local/share/Steam/steamapps/compatdata/2073850/pfx/drive_c/users/steamuser/AppData/Local/Discovery/Saved/Config/WindowsClient/GameUserSettings.ini";
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/4EveryoneNixOS/modules/home-manager/configurations/gaming/tricks/The_Finals/Engine.ini";
    };

}
