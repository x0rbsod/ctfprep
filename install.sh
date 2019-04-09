#!/bin/bash

# set up new configs and db
mkdir ~/.env
cp ./.bashrc ~/.bashrc
cp ./db.txt ~/.env
source ~/.bashrc

# run setup script
chmod +x ./kalisetup.sh && ./kalisetup.sh


