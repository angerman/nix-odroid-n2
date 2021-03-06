{ lib, config, pkgs, ... }:

{
  imports = [
    ./packages.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_odroid_n2_5_6;
  boot.kernelParams = [
    "no_console_suspend"
    "consoleblank=0"
    "fsck.fix=yes"
    "fsck.repair=yes"
    "net.ifnames=0"
    "elevator=noop"
    "ethaddr=\${ethaddr}"
    "enable_wol=1"
    "usb-xhci.tablesize=2"
  ];

  boot.consoleLogLevel = lib.mkDefault 7;

  boot.supportedFilesystems = lib.mkForce [ "btrfs" "vfat" "cifs" ];

  # Since 20.03, you must explicitly specify to use dhcp on an interface
  networking.interfaces.eth0.useDHCP = true;
  
}
