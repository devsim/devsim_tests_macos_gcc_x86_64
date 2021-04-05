#!/bin/bash
set -e

if [ ! -d ${HOME}/anaconda ]; then
( cd ${HOME} && curl -L -O https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh && bash Miniconda3-latest-MacOSX-x86_64.sh -b -p ${HOME}/anaconda )
fi

${HOME}/anaconda/bin/conda create  -y --name python38_devsim python=3.8
# mkl is not implicit to mkl see: https://mruss.dev/numpy-mkl/
${HOME}/anaconda/bin/conda install -y --name python38_devsim numpy mkl cmake blas=*=*mkl

