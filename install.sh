#!/usr/bin/env bash

# Script d'autoinstal·lació per a nixos-config
set -e # Atura l'script si hi ha algun error

echo "--- NixOS Config Autoinstall ---"

# 1. Preguntar dades a l'usuari
read -p "Introdueix el nou nom d'usuari: " NEW_USER
read -p "Introdueix el nou hostname (nom del PC): " NEW_HOSTNAME

# 2. Copiar la configuració de maquinari actual
echo "Copiant la configuració de maquinari del sistema..."
cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix

# 3. Personalitzar el configuration.nix (usant sed)
# Nota: Això suposa que tens les etiquetes "CHANGE_USER" i "CHANGE_HOSTNAME" al fitxer
echo "Personalitzant fitxers de configuració..."
sed -i "s/networking.hostName = \".*\";/networking.hostName = \"$NEW_HOSTNAME\";/g" configuration.nix
sed -i "s/users.users\..*\ =/users.users.$NEW_USER =/g" configuration.nix

# 4. Afegir canvis a Git (necessari per a Flakes)
git add .

# 5. Aplicar la configuració
echo "Iniciant la instal·lació (es demanarà contrasenya sudo)..."
sudo nixos-rebuild switch --flake .#$NEW_HOSTNAME || sudo nixos-rebuild switch --flake .

echo "--- Instal·lació completada! Reinicia per veure els canvis ---"