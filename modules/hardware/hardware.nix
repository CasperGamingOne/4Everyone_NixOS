{ config, pkgs, ... }:
{

    boot = {
        # Bootloader
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        # Use latest xanmod kernel + fixes and modules
        kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
        initrd.kernelModules = [ "evdi" ];
        extraModulePackages = [ config.boot.kernelPackages.evdi ];
        extraModprobeConfig = ''
            options nvidia NVreg_PreserveVideoMemoryAllocations=0
            options nvidia NVreg_TemporaryFilePath=/var/tmp
        '';
    };

    # Config + Variables
    environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD";     # Prefer the modern iHD backend
        NIXOS_OZONE_WL = "1";
        KWIN_DRM_PREFER_COLOR_DEPTH = "24";
    };
    zramSwap = {
        enable = true;
        algorithm = "zstd";
    };

    hardware.firmware = [ pkgs.sof-firmware ];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            intel-media-driver     # VA-API (iHD) userspace
            vpl-gpu-rt             # oneVPL (QSV) runtime
        ];
    };

    # nVIDIA Support
    hardware.nvidia = {
        open = false;
        package = config.boot.kernelPackages.nvidiaPackages.production;
        modesetting.enable = true;
        powerManagement.enable = true;
        nvidiaPersistenced = true;
        dynamicBoost.enable = true;
        prime = {
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
            offload = {
                enable = true;
                enableOffloadCmd = true;
            };
        };
    };

    # Bluetooth Support
    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
        General = {
            Enable = "Source,Sink,Media,Socket";
            Experimental = true;
            FastConnectable = true;
        };
        Policy = {
            AutoEnable = true;
        };
    };
}
