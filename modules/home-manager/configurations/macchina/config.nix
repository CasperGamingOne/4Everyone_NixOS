{ config, pkgs, ... }:
{

    home.file."macchina.toml" = {
        enable = true;
        target = "/.config/macchina/macchina.toml";
        text = ''

# Specifies the network interface to use for the LocalIP readout
interface = "enp60s0u1u1i5"

# Lengthen uptime output
long_uptime = true

# Lengthen shell output
long_shell = false

# Lengthen kernel output
long_kernel = true

# Toggle between displaying the current shell or your user's default one.
current_shell = true

# Toggle between displaying the number of physical or logical cores of your
# processor.
physical_cores = true

# Disks to show disk usage for. Defaults to `["/"]`.
disks = ["/", "/mnt/8ccd8faf-322a-497b-b406-f75b2bfc9289/"]

# Show percentage next to disk information
disk_space_percentage = true

# Show percentage next to memory information
memory_percentage = true

# Themes need to be placed in "$XDG_CONFIG_DIR/macchina/themes" beforehand.
# e.g.:
#  if theme path is /home/foo/.config/macchina/themes/Sodium.toml
#  theme should be uncommented and set to "Sodium"
#
# theme = ""

# Displays only the specified readouts.
# Accepted values (case-sensitive):
#   - Host
#   - Machine
#   - Kernel
#   - Distribution
#   - OperatingSystem
#   - DesktopEnvironment
#   - WindowManager
#   - Resolution
#   - Backlight
#   - Packages
#   - LocalIP
#   - Terminal
#   - Shell
#   - Uptime
#   - Processor
#   - ProcessorLoad
#   - Memory
#   - Battery
#   - GPU
#   - DiskSpace
# Example:
show = [
    "Host",
    "Machine",
    "Kernel",
    "Distribution",
    "DesktopEnvironment",
    "WindowManager",
    "Resolution",
    "Backlight",
    "Packages",
    "Uptime",
    "Processor",
    "ProcessorLoad",
    "Battery",
    "Memory",
    "GPU",
    "DiskSpace"
]

        '';
    };

}
