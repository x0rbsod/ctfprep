#!/bin/bash

# ------------------------------ #
#  move dotfiles and db          #
# ------------------------------ #
mkdir ~/.env
cp ./dotfiles/.bashrc ~
cp ./dotfiles/.vimrc ~
mkdir -p ~/.config/terminator
cp ./dotfiles/terminator-config ~/.config/terminator/config
cp ./db.txt ~/.env
source ~/.bashrc

# ------------------------------ #
#  basic setup                   #
# ------------------------------ #
apt clean && apt update && apt upgrade -y
apt install -y terminator git
apt install -y python-setuptools
easy_install pip

# ------------------------------ #
#  tools                         #
# ------------------------------ #

# impacket
cd /opt
git clone https://github.com/CoreSecurity/impacket.git
cd /opt/impacket && python setup.py install
cp /opt/impacket/examples/smbrelayx.py /usr/bin
chmod 755 /usr/bin/smbrelayx.py
cp /opt/impacket/examples/wmiexec.py /usr/bin
chmod 755 /usr/bin/wmiexec.py

# fuzzdb
cd /opt
git clone https://github.com/fuzzdb-project/fuzzdb.git

# empire (run setup manually)
cd /opt
git clone https://github.com/PowerShellEmpire/Empire.git

# veil
cd /opt
git clone https://github.com/Veil-Framework/Veil.git
cd /opt/Veil/Veil-Evasion/setup && ./setup.sh
cd /opt/Veil/Veil-Catapult && ./setup.sh

# powersploit
cd /opt
git clone https://github.com/PowerShellMafia/PowerSploit.git

# windows local enumration
cd /opt
git clone https://github.com/bitsadmin/miscellaneous
mv miscellaneous localrecon.cmd 

# windows exploit suggester
cd /opt
git clone https://github.com/GDSSecurity/Windows-Exploit-Suggester
pip install xlutils
cd /opt/Windows-Exploit-Suggester
python windows-exploit-suggester.py --update
cd /opt
git clone https://github.com/bitsadmin/wesng
cd /opt/wesng
python wes.py --update

# nix exploit/enumration
cd /opt
git clone https://github.com/InteliSecureLabs/Linux_Exploit_Suggester
git clone https://github.com/pentestmonkey/unix-privesc-check
