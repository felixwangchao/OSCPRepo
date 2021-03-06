#!/bin/sh
#
# If in a VM and Copy/Paste is NOT working: apt-get install open-vm-tools open-vm-desktop
# and then reboot!!
#

echo "### Downloading things...### \n\n"
echo "Install new software: atom crackmapexec exiftool gobuster git nbtscan-unixwiz nfs-common flameshot libldap2-dev libsasl2-dev powershell-preview"
curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list'
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/debian/stretch/prod stretch main" >> /etc/apt/sources.list.d/microsoft.list'
apt-get update
apt-get install -y atom crackmapexec exiftool gobuster git nbtscan-unixwiz nfs-common flameshot libldap2-dev libsasl2-dev powershell-preview

echo "\nCloning ADLdapEnum\n"
direc=/root/Documents/ADLdapEnum
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/CroweCybersecurity/ad-ldap-enum.git $direc; fi

echo "\nCloning Impacket \n"
direc=/root/Documents/Impacket
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/CoreSecurity/impacket.git $direc; fi

echo "\nCloning John Jumbo\n"
direc=/root/Documents/JohnJumbo
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/magnumripper/JohnTheRipper.git $direc; fi

echo "\nCloning LdapDD\n"
direc=/root/Documents/LdapDD
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/dirkjanm/ldapdomaindump.git $direc; fi

echo "\nCloning Nishang\n"
direc=/root/Documents/Nishang
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/samratashok/nishang.git $direc; fi

echo "\nCloning Nullinux\n"
direc=/root/Documents/Nullinux
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/m8r0wn/nullinux.git $direc; fi

echo "\nCloning OSCPRepo \n"
direc=/root/Documents/OSCPRepo
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/rewardone/OSCPRepo.git $direc; fi

echo "\nCloning Parameth\n"
direc=/root/Documents/Parameth
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/maK-/parameth.git $direc; fi

echo "\nCloning PowerCat\n"
direc=/root/Documents/PowerCat
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/besimorhino/powercat.git $direc; fi

echo "\nCloning PowershellEmpire\n"
direc=/root/Documents/Empire
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/EmpireProject/Empire.git $direc; fi

echo "\nCloning PowerSploit\n"
direc=/root/Documents/PowerSploit
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/PowerShellMafia/PowerSploit.git $direc; fi

echo "\nCloning Python PTY Shells \n"
direc=/root/Documents/PythonPTYShells
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/infodox/python-pty-shells.git $direc; fi

echo "\nCloning VHostScan\n"
direc=/root/Documents/VHostScan
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/codingo/VHostScan.git $direc; fi

echo "\nCloning Vulners.nse script \n"
direc=/root/Documents/Vulners
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/vulnersCom/nmap-vulners.git $direc; fi

echo "\nCloning Vulners exploit database/search tool \n"
direc=/root/Documents/Getsploit
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/vulnersCom/getsploit.git $direc; fi

echo "\n ### Processing actions...### \n\n"
echo "Setup install Impacket"
chmod +x /root/Documents/Impacket/setup.py && cd /root/Documents/Impacket && ./setup.py install

echo "\nCopy vulners to nmap scripts location \n"
cp /root/Documents/Vulners/vulners.nse /usr/share/nmap/scripts/vulners.nse

echo "\nSetup Getsploit\n"
cd /root/Documents/Getsploit && chmod +x setup.py && ./setup.py install

echo "\nSetup OSCPRepo \n"
pip install colorama
rm -rf /root/scripts/*
cp -r /root/Documents/OSCPRepo/scripts /root/
cp -r /root/Documents/OSCPRepo/lists /root/

echo "\nSetup Empire\n"
#Empire calls ./setup from ./install, so needs to be in its directory
cd /root/Documents/Empire/setup && chmod +x setup_database.py && ./install.sh

echo "\nBuilding John Jumbo\n"
if [ ! -f ~/Documents/JohnJumbo/run/john ]; then cd /root/Documents/JohnJumbo/src && ./configure && make; fi

echo "\nSetup VHostScan\n"
cd /root/Documents/VHostScan && python3 -m pip install -r requirements.txt 2&>/dev/null
python3 -m pip install python-levenshtein 2&>/dev/null
cd /root/Documents/VHostScan && cat setup.py | sed -e 's/NUM_INSTALLED/num_installed/g' && python3 setup.py install

echo "\nSetup Parameth\n"
cd /root/Documents/Parameth && pip install -U -r requirements.txt

echo "\nSetup ADLDAP\n"
cd /root/Documents/ADLdapEnum && pip install python-ldap && chmod +x ad-ldap-enum.py

echo "\nSetup LdapDD\n"
cd /root/Documents/LdapDD && chmod +x setup.py && chmod +x ldapdomaindump.py && python setup.py install

echo "\nSetup Nullinux\n"
cp -p /root/Documents/Nullinux /usr/local/bin

echo "\nDownloading additional lists: secLists fuzzdb naughtystrings payloadallthethings probable-wordlists\n"
webDirec=/root/lists/Web
direc=/root/lists/secLists
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/danielmiessler/SecLists.git $direc; fi
ln -s $direc/Discovery/Web-Content $webDirec
direc=/root/lists/fuzzdb
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/fuzzdb-project/fuzzdb.git $direc; fi
direc=/root/lists/naughty
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/minimaxir/big-list-of-naughty-strings.git $direc; fi
direc=/root/lists/payloadsAllTheThings
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git $direc; fi
direc=/root/lists/Password/probableWordlists
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/berzerk0/Probable-Wordlists.git $direc; fi
direc=/root/lists/Password/passphrases
if [ -d "$direc" ]; then cd $direc && git pull; else git clone https://github.com/initstring/passphrase-wordlist.git $direc; fi

echo "\nMake sure Metasploit is ready to go \n"
systemctl start postgresql
msfdb reinit

echo "\nUpdating exploit-db, getsploit (vulners), and nmap scripts \n"
searchsploit -u
getsploit -u
nmap --script-updatedb

echo "\nEditing dotdotpwn so you don't have to press 'ENTER' to start it \n"
sed -e "s/<STDIN>;/#<STDIN>;/" /usr/share/dotdotpwn/dotdotpwn.pl > /usr/share/dotdotpwn/dotdotpwn_TMP && mv /usr/share/dotdotpwn/dotdotpwn_TMP /usr/share/dotdotpwn/dotdotpwn.pl
chmod +x /usr/share/dotdotpwn/dotdotpwn.pl
direc=/usr/share/dotdotpwn/Reports
if [ ! -d "$direc" ]; then mkdir /usr/share/dotdotpwn/Reports; fi

echo "\nSetup Sparta for use with reconscan \n"
mv /usr/share/sparta/app/settings.py /usr/share/sparta/app/settings_orig.py
mv /usr/share/sparta/controller/controller.py /usr/share/sparta/controller/controller_orig.py
mv /etc/sparta.conf /etc/sparta_orig.conf
cp /root/Documents/OSCPRepo/scripts/random/Sparta/settings.py /usr/share/sparta/app/settings.py
cp /root/Documents/OSCPRepo/scripts/random/Sparta/controller.py /usr/share/sparta/controller/controller.py
cp /root/Documents/OSCPRepo/scripts/random/Sparta/sparta.conf /etc/sparta.conf

echo "\n ### Optional packages you might utilize in the future ### \n"
echo "apt-get install automake remmina freerdpx11 alacarte shutter"
echo "Shutter has been removed from Kali due to dependencies, find an alternative (currently FlameShot)"
echo "Keepnote may be removed from latest Kali as well. Source: http://keepnote.org/download/keepnote_0.7.8-1_all.deb"
