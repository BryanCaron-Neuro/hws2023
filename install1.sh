unset PYTHONPATH
MINICONDA_INSTALLER_SCRIPT=Miniconda3-latest-Linux-x86_64.sh
MINICONDA_PREFIX=/usr/local
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh &> /dev/null
chmod +x $MINICONDA_INSTALLER_SCRIPT
./$MINICONDA_INSTALLER_SCRIPT -b -f -p $MINICONDA_PREFIX &> /dev/null
conda install -c conda-forge -y git-annex &> /dev/null
pip install datalad boutiques nilearn &> /dev/null
