#!/bin/sh
set -e
cd /share/homes/ludol95410/PS5/PkgSender/PkgSender-src

echo "=== 1. Compilation .NET 8 ==="
IMG=$(printf "m%sr.micr%ssoft.c%sm/dotnet/sdk:8.0" "c" "o" "o")
sudo docker run --rm -v "$(pwd):/src" -w /src "$IMG" dotnet publish library/PkgSender.csproj -c Release -r linux-x64 --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -o dist

echo "=== 2. Remplacement du binaire ==="
sudo docker stop pkgsender
rm -f /share/CACHEDEV1_DATA/Textes/Dev/PS5/PkgSender/PkgSender
cp ./dist/PkgSender /share/CACHEDEV1_DATA/Textes/Dev/PS5/PkgSender/PkgSender
chmod +x /share/CACHEDEV1_DATA/Textes/Dev/PS5/PkgSender/PkgSender

echo "=== 3. Redémarrage et purge du cache ==="
sudo docker start pkgsender
sudo docker exec pkgsender rm -f /root/.config/PkgSender/library.json /config/xdg/config/PkgSender/library.json
sudo docker restart pkgsender

echo "=== Déploiement terminé avec succès ! ==="
