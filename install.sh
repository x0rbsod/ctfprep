#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# ------------------------------ #
#  move dotfiles and db          #
# ------------------------------ #
mkdir ~/.env
cp ./dotfiles/.bashrc ~
cp ./dotfiles/.vimrc ~
mkdir -p ~/.config/terminator
cp ./dotfiles/terminator-config ~/.config/terminator/config
cp ./db.txt ~/.env

# ------------------------------ #
#  basic setup                   #
# ------------------------------ #
apt clean && apt update && apt upgrade -y
apt install -y \
   terminator \
   git \
   python-setuptools \
   ltrace \
   gcc-multilib \
   strace \
   python-pip \
   python-dev \
   libssl-dev \
   libffi-dev \
   build-essential
pip install --upgrade pip

# ------------------------------ #
#  tools                         #
# ------------------------------ #

# metasploit
apt install metasploit-framework

# pwntools
pip install --upgrade pwntools

# impacket
git clone https://github.com/CoreSecurity/impacket.git /opt/impacket
cd /opt/impacket && python setup.py install

# fuzzdb
git clone https://github.com/fuzzdb-project/fuzzdb.git /opt/fuzzdb

# empire (run setup manually)
git clone https://github.com/PowerShellEmpire/Empire.git /opt/Empire

# veil
git clone https://github.com/Veil-Framework/Veil.git /opt/Veil
/opt/veil/config/setup.sh --force --silent

# powersploit
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit

# searchsploit
apt -y install exploitdb exploitdb-papers exploitdb-bin-sploits
searchsploit -u

# windows local enumration
git clone https://github.com/bitsadmin/miscellaneous /opt/localrecon.cmd

# windows exploit suggester
git clone https://github.com/GDSSecurity/Windows-Exploit-Suggester /opt/Windows-Exploit-Suggester
pip install xlutils
cd /opt/Windows-Exploit-Suggester
python windows-exploit-suggester.py --update
git clone https://github.com/bitsadmin/wesng /opt/wesng
cd /opt/wesng
python wes.py --update

# nix exploit/enumration
git clone https://github.com/InteliSecureLabs/Linux_Exploit_Suggester /opt/Linux_Exploit_Suggester
git clone https://github.com/pentestmonkey/unix-privesc-check /opt/unix-privesc-check

# oletools
apt install python-oletools

# PEDA binary analysis
git clone https://github.com/longld/peda.git /opt/peda
echo "source /opt/peda/peda.py" >> ~/.gdbinit

# ------------------------------ #
#  finish up                     #
# ------------------------------ #
source ~/.bashrc
