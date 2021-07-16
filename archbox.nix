{ config, pkgs, ... }:

let
    archbox = pkgs.stdenv.mkDerivation rec {
        name = "archbox";
        src = pkgs.fetchFromGitHub {
            owner = "lemniskett";
            repo = "archbox";
            rev = "6ab44021605ff7592692562871aa654eec1ed6bb";
            sha256 = "0qgar6w2q1wsglx3zyj02mygypxs6bplrj43k61bkwz9g9d31yw5";
        };
        sourceRoot = ".";
        installPhase = ''
            mkdir -p $out
            cd source
            export FORCE_INSTALL_CONFIG=1
            export ETC_DIR=$out/etc
            export PREFIX=$out
            export ARCHBOX_USER=amy
            export MOUNT_RUN=no
            ${pkgs.bash}/bin/bash install.sh
        '';
    };
in
{
    environment.systemPackages = [ archbox ];
    environment.etc = { 
        "archbox.conf" = { 
            source = "${archbox}/etc/archbox.conf";
        };
    };
}
