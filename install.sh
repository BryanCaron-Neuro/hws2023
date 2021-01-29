#!/usr/bin/env bash

sudo apt-get install datalad &>/dev/null && echo Installed DataLad
pip install nilearn boutiques &>/dev/null && echo Installed Python dependencies
sudo cp fslstats /bin && sudo chmod 755 /bin/fslstats && echo Installed fslstats
git config --global user.email "example@example.org" && git config --global user.name "HIBALL Winter School container" && echo Configured Git
mkdir -p $HOME/.cache/boutiques/production && mv zenodo-4472771.json $HOME/.cache/boutiques/production