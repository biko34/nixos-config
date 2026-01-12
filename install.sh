#!/usr/bin/env bash
set -e

echo "🚀 Iniciant instal·lació de la configuració NixOS..."

# 1. Recollida de dades
read -p "👤 Introdueix el teu nom d'usuari (Ex: carlos): " NEW_USER
read -p "💻 Introdueix el nom de l'ordinador (Hostname): " NEW_HOSTNAME
read -p "📧 Introdueix el teu correu de GitHub: " NEW_EMAIL
read -p "✍️  Introdueix el teu nom complet (Git): " NEW_NAME

# 2. Copiar Hardware Config
echo "📋 Copiant configuració de maquinari actual..."
cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix

# 3. Personalització declarativa (Sed)
echo "🔧 Personalitzant fitxers .nix..."
# Canviem l'usuari i hostname al configuration.nix
sed -i "s/TEMPLATE_USER/$NEW_USER/g" configuration.nix
sed -i "s/TEMPLATE_HOSTNAME/$NEW_HOSTNAME/g" configuration.nix

# Canviem les dades de Git al home.nix
sed -i "s/TEMPLATE_NAME/$NEW_NAME/g" home.nix
sed -i "s/TEMPLATE_EMAIL/$NEW_EMAIL/g" home.nix

# 4. Neteja de fitxers existents (per evitar l'error de 'clobbered')
echo "🧹 Netejant rutes de configuració velles..."
rm -rf ~/.config/fish ~/.config/ghostty ~/.config/starship.toml || true

# 5. Afegir a Git i Aplicar
echo "📦 Preparant Flake..."
git add .

echo "⚙️ Aplicant configuració (rebuild)..."
# Intentem aplicar-ho amb el nou hostname
sudo nixos-rebuild switch --flake .#$NEW_HOSTNAME || sudo nixos-rebuild switch --flake .

echo "✅ INSTAL·LACIÓ FINALITZADA!"
echo "⚠️ RECORDA: Reinicia el sistema per entrar amb l'usuari $NEW_USER."