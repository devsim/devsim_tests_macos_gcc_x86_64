#!/bin/bash
set -e

if [ ! -d ${HOME}/anaconda ]; then
( cd ${HOME} && curl -O https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh  && bash Miniconda2-latest-Linux-x86_64.sh -b -p ${HOME}/anaconda )
${HOME}/anaconda/bin/conda create -y --name python3 python=3
${HOME}/anaconda/bin/conda install -y numpy mkl
${HOME}/anaconda/bin/conda create -y --name python3 python=3
${HOME}/anaconda/bin/conda install -y -n python3 numpy mkl
fi
