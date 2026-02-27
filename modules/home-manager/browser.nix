{ config, lib, pkgs, ... }:
{

    programs.chromium = {
        enable = true;
        package = pkgs.brave;
        /*extraOpts = {
            "BraveRewardsDisabled" = 1;
            "BraveWalletDisabled" = 1;
            "BraveVPNDisabled" = 1;
            "ExtensionManifestV2Availability" = 3;
            "BrowserSignin" = 0;
            "SyncDisabled" = true;
            "PasswordManagerEnabled" = false;
        };*/
        extensions = [
            "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
            "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
            "enamippconapkdmgfgjchkhakpfinmaj" # dearrow
        ];
    };

}
