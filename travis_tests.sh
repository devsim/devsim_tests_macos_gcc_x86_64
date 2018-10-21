#!/bin/bash
set -e
BASEDIR="${PWD}"
TAG=${1}
TAGDIR=devsim_osx_gcc_${TAG}
TAGTGZ=${TAGDIR}.tgz
#DEVSIM_PY=${TAGDIR}/bin/devsim
#DEVSIM_PY3=${TAGDIR}/bin/devsim_py3
DEVSIM_TCL=${TAGDIR}/bin/devsim_tcl
DEVSIM_LIB=${TAGDIR}/lib
ANACONDA_PATH=${HOME}/anaconda
ANACONDA27_PATH=${ANACONDA_PATH}/envs/python27
ANACONDA37_PATH=${ANACONDA_PATH}/envs/python37

#curl -L -O https://github.com/devsim/devsim/releases/download/${TAG}/${TAGTGZ}
#tar xzf ${TAGTGZ} 

mkdir -p bin

cat << EOF > bin/devsim
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\${progname}"\`
ANACONDA_PATH=${ANACONDA_PATH}
export PYTHONHASHSEED=0
# sequential speeds up small examples
export MKL_NUM_THREADS=1
source \${ANACONDA_PATH}/bin/activate python27
export DYLD_FALLBACK_LIBRARY_PATH=\${CONDA_PREFIX}/lib
export PYTHONPATH="\${curdir}"/../${DEVSIM_LIB}
python "\$*"
EOF
chmod +x bin/devsim

cat << EOF > bin/devsim_py3
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\${progname}"\`
ANACONDA_PATH=${ANACONDA_PATH}
export PYTHONHASHSEED=0
# sequential speeds up small examples
export MKL_NUM_THREADS=1
source \${ANACONDA_PATH}/bin/activate python37
export PYTHONPATH="\${curdir}"/../${DEVSIM_LIB}
python "\$*"
EOF
chmod +x bin/devsim_py3

cat << EOF > bin/devsim_tcl
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\${progname}"\`
ANACONDA_PATH=${ANACONDA_PATH}
export DYLD_LIBRARY_PATH=\${ANACONDA_PATH}/lib
export TCL_LIBRARY=\${ANACONDA_PATH}/lib/tcl8.6
# sequential speeds up small examples
export MKL_NUM_THREADS=1
\${curdir}/../${DEVSIM_TCL} "\$*"
EOF
chmod +x bin/devsim_tcl

ln -sf ${TAGDIR}/testing .
ln -sf ${TAGDIR}/examples .

rm -rf run && mkdir run
(cd run && cmake -DDEVSIM_TEST_GOLDENDIR=${BASEDIR}/goldenresults -DDEVSIM_PY_TEST_EXE=${BASEDIR}/bin/devsim -DDEVSIM_PY3_TEST_EXE=${BASEDIR}/bin/devsim_py3 -DDEVSIM_TCL_TEST_EXE=${BASEDIR}/bin/devsim_tcl ..)
(cd run && ctest -j4)

