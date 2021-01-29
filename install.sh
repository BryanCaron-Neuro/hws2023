#!/usr/bin/env bash

pip install nilearn &>/dev/null && echo Installed Nilearn
unset PYTHONPATH
MINICONDA_INSTALLER_SCRIPT=Miniconda3-latest-Linux-x86_64.sh
MINICONDA_PREFIX=/usr/local
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh &> /dev/null && echo Downloaded Conda
chmod +x $MINICONDA_INSTALLER_SCRIPT
./$MINICONDA_INSTALLER_SCRIPT -b -f -p $MINICONDA_PREFIX &> /dev/null && echo Installed Conda
conda install -c conda-forge -y git-annex &> /dev/null && echo Installed git-annex
apt install netbase &>/dev/null && echo Installed apt packages
conda install datalad datalad-osf boutiques &> /dev/null && echo Installed DataLad and Boutiques

sudo cp fslstats /bin && sudo chmod 755 /bin/fslstats && echo Installed fslstats
git config --global user.email "example@example.org" && git config --global user.name "HIBALL Winter School container" && echo Configured Git
mkdir -p $HOME/.cache/boutiques/production && mv zenodo-4472771.json $HOME/.cache/boutiques/production