#!/bin/bash

# check if .list file already exists
if [ -f /etc/apt/sources.list.d/box86.list ]; then
  sudo rm -f /etc/apt/sources.list.d/box86.list || exit 1
fi
# check if .sources file already exists
if [ -f /etc/apt/sources.list.d/box86.sources ]; then
  sudo rm -f /etc/apt/sources.list.d/box86.sources || exit 1
fi
# download gpg key from specified url
if [ -f /usr/share/keyrings/box86-archive-keyring.gpg ]; then
  sudo rm -f /usr/share/keyrings/box86-archive-keyring.gpg
fi
sudo mkdir -p /usr/share/keyrings
wget -qO- "https://pi-apps-coders.github.io/box86-debs/KEY.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/box86-archive-keyring.gpg
# create .sources file
echo "Types: deb
URIs: https://Pi-Apps-Coders.github.io/box86-debs/debian
Suites: ./
Signed-By: /usr/share/keyrings/box86-archive-keyring.gpg" | sudo tee /etc/apt/sources.list.d/box86.sources >/dev/null

sudo apt update
sudo apt install box86-rpi4arm64 -y
cd ~/ham314/temp

version=9.17
# Download wine to /opt
wget https://github.com/Pi-Apps-Coders/files/releases/download/large-files/wine-i386-${version}.tar.gz -O wine-${version}.tar.gz
sudo tar -xvf wine-${version}.tar.gz -C /opt
rm -f wine-${version}.tar.gz

#edit wine.inf to disable mime-associations. Nobody wants to double-click a text file, wonder why nothing is happening, then watch 15 Wine notepad windows pop up. Ask me how I know.
sudo sed -i 's/winemenubuilder.exe -a -r/winemenubuilder.exe -r/' /opt/wine-${version}/share/wine/wine.inf #See: https://askubuntu.com/a/400430

#download winetricks
wget -O winetricks "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
sudo mv winetricks /opt/wine-${version}/bin/winetricks
sudo chmod +x /opt/wine-${version}/bin/winetricks

#download Mono to universal location (to be installed automatically in all wine prefixes)
#according to https://wiki.winehq.org/Mono#Versions, use Mono 9.3.0 for Wine 9.17
#wine mono pacakge is called -x86 but contains both x86 and x86_64 binaries
sudo mkdir -p /opt/wine-${version}/share/wine/mono
wget -O "wine-mono-9.3.0-x86.tar.xz" 'https://dl.winehq.org/wine/wine-mono/9.3.0/wine-mono-9.3.0-x86.tar.xz'
sudo tar -xvf "wine-mono-9.3.0-x86.tar.xz" -C "/opt/wine-${version}/share/wine/mono"
rm -f "wine-mono-9.3.0-x86.tar.xz"

#download Gecko to universal location (to be installed automatically in all wine prefixes)
#according to https://wiki.winehq.org/Gecko, use Gecko 2.47.4 for Wine 8.6
sudo mkdir -p /opt/wine-${version}/share/wine/gecko
wget -O "wine-gecko-2.47.4-x86.tar.xz" 'https://dl.winehq.org/wine/wine-gecko/2.47.4/wine-gecko-2.47.4-x86.tar.xz'
sudo tar -xvf "wine-gecko-2.47.4-x86.tar.xz" -C "/opt/wine-${version}/share/wine/gecko"
rm -f "wine-gecko-2.47.4-x86.tar.xz"

echo "Creating terminal commands:"
echo "  - winecfg"
sudo ln -s /opt/wine-${version}/bin/winecfg /usr/local/bin/winecfg
echo "  - wineserver"
sudo ln -s /opt/wine-${version}/bin/wineserver /usr/local/bin/wineserver
echo "  - wineboot"
sudo ln -s /opt/wine-${version}/bin/wineboot /usr/local/bin/wineboot

echo "  - wine"
echo "#!/bin/bash
if [ -d /opt/wine-${version}/mesa ];then
  export LD_LIBRARY_PATH=/opt/wine-${version}/mesa/lib/arm-linux-gnueabihf/
  export LIBGL_DRIVERS_PATH=/opt/wine-${version}/mesa/lib/arm-linux-gnueabihf/dri/
  export VK_ICD_FILENAMES=/opt/wine-${version}/mesa/share/vulkan/icd.d/broadcom_icd.armv7l.json
fi
/opt/wine-${version}/bin/wine"' "$@"' | sudo tee /usr/local/bin/wine >/dev/null

echo "  - winetricks"
echo "#!/bin/bash
BOX86_NOBANNER=1 /opt/wine-${version}/bin/winetricks"' "$@"' | sudo tee /usr/local/bin/winetricks >/dev/null

#make them all executable
sudo chmod +x /usr/local/bin/winecfg /usr/local/bin/wineserver /usr/local/bin/wineboot /usr/local/bin/wine /usr/local/bin/winetricks

#get icons from wine-stuff repo
git clone https://github.com/Botspot/wine-stuff
sudo mv wine-stuff/icons /opt/wine-${version}
sudo mv wine-stuff/Windows_10.msstyles /opt/wine-${version}
sudo chown -R root:root /opt/wine-${version}
rm -rf wine-stuff

#create menu launchers
#Remove wine auto-generated desktop files that handle mimetypes. Nobody in their right mind would want this.
#See: https://askubuntu.com/a/400430
rm -f ~/.local/share/mime/packages/x-wine*
rm -f ~/.local/share/applications/wine-extension*
rm -f ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
rm -f ~/.local/share/mime/application/x-wine-extension*

echo "[Desktop Entry]
StartupNotify=true
Terminal=false
Type=Application
Name=Wine Configuration
Exec=wine winecfg
Icon=/opt/wine-${version}/icons/winecfg.png
Categories=System;
Comment=Configure wine" | sudo tee /usr/share/applications/wine-config.desktop >/dev/null

echo "[Desktop Entry]
Name=Winetricks
Comment=Work around problems and install applications under Wine
Exec=bash -c 'BOX64_NOBANNER=1 box64 winetricks --gui'
Terminal=false
Icon=/opt/wine-${version}/icons/winetricks.png
Type=Application
Categories=System;" | sudo tee /usr/share/applications/wine-tricks.desktop >/dev/null

echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Wine Desktop
Comment=Wine graphical desktop environment to mimic a Windows OS
Icon=/opt/wine-${version}/icons/wine-desktop.png
Exec=wine explorer /desktop=shell,1280x720
Terminal=false
Categories=System;" | sudo tee /usr/share/applications/wine-explorer.desktop >/dev/null

echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Wine Program Manager
Comment=Install/Remove Windows programs
Icon=/opt/wine-${version}/icons/wine-program-manager.png
Exec=wine uninstaller
Terminal=false
Categories=System;" | sudo tee /usr/share/applications/wine-uninstaller.desktop >/dev/null

echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Wine Task Manager
Comment=View running processes within Wine
Icon=/opt/wine-${version}/icons/winetask.png
Exec=wine taskmgr
Terminal=false
Categories=System;" | sudo tee /usr/share/applications/wine-taskmgr.desktop >/dev/null

echo "[Desktop Entry]
StartupNotify=false
Version=1.0
Type=Application
Name=Wine Killer
Comment=Terminate any running Wine processes
Icon=/opt/wine-${version}/icons/winestop.png
Exec=wineserver -k
Terminal=false
Categories=System;" | sudo tee /usr/share/applications/wine-killer.desktop >/dev/null

echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Wine Reset
Comment=Clean out the default Wine prefix and start over
Icon=/opt/wine-${version}/icons/wine-regenerate.png
Exec=bash -c "\""yad --window-icon=/opt/wine-${version}/icons/wine-regenerate.png --title='Wine Reset' --text='Are you sure you want to DELETE all data and applications in your Wine prefix and start over?' --center --button=Cancel:1 --button=Yes:0 --on-top && ${DIRECTORY}/etc/terminal-run 'echo y | winetricks annihilate -q ; generate-wine-prefix' 'Generating Wine prefix...'"\""
Terminal=false
Categories=System;" | sudo tee /usr/share/applications/wine-regenerate.desktop >/dev/null


# TODO download premade drive
cd ~
wget "https://kd9yqk.com/downloads/vara_wine.zip"
unzip vara_wine.zip

APPDIR="${HOME}"/.local/share/applications
PREFIXDIR="${HOME}"/.wine
#Creating Desktop Entry
mkdir -p "${APPDIR}"/VARA
echo "[Desktop Entry]
Name=VARA HF
GenericName=VARA HF
Comment=VARA HF is a shareware ham radio OFDM software modem for RMS Express and other messaging clients.
Exec=env WINEPREFIX=\"${PREFIXDIR}\" WINEDEBUG=-all wine \"${PREFIXDIR}/drive_c/VARA/VARA.exe\"
#Icon=$(dirname "$0")/icon-64.png
Terminal=false
StartupNotify=false
Type=Application
StartupWMClass=vara.exe
Categories=HamRadio;" > "${APPDIR}"/VARA/varahf.desktop

echo "[Desktop Entry]
Name=VARA FM
GenericName=VARA FM
Comment=VARA FM is a shareware ham radio OFDM software modem for RMS Express and other messaging clients.
Exec=env WINEPREFIX=\"${PREFIXDIR}\" WINEDEBUG=-all wine \"${PREFIXDIR}/drive_c/VARAFM/VARAFM.exe\"
#Icon=$(dirname "$0")/icon-64.png
Terminal=false
StartupNotify=false
Type=Application
StartupWMClass=varafm.exe
Categories=HamRadio;" > "${APPDIR}"/VARA/varafm.desktop

#echo "[Desktop Entry]
#Name=VaraAC
#GenericName=VaraAC
#Comment=VarAC is cool.
#Exec=env WINEPREFIX=\"${PREFIXDIR}\" WINEDEBUG=-all wine \"${PREFIXDIR}/drive_c/VaraAC/VaraAC.exe\"
#Icon=$(dirname "$0")/icon-64.png
#Terminal=false
#StartupNotify=false
#Type=Application
#StartupWMClass=varaac.exe
#Categories=HamRadio;" > "${APPDIR}"/VARA/varaac.desktop
