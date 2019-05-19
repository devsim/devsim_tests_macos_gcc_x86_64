#!/bin/bash
set -e

if [ ! -d ${HOME}/anaconda ]; then
( cd ${HOME} && curl -L -O https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh && bash Miniconda3-latest-MacOSX-x86_64.sh -b -p ${HOME}/anaconda )
fi

${HOME}/anaconda/bin/conda install -y --name base cmake
${HOME}/anaconda/bin/conda create  -y --name python37_devsim python=3.7
${HOME}/anaconda/bin/conda install -y --name python37_devsim numpy mkl

