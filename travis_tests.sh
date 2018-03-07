#!/bin/bash
set -e
BASEDIR="${PWD}"
TAG=${1}
TAGDIR=devsim_osx_gcc_${TAG}
TAGTGZ=${TAGDIR}.tgz
DEVSIM_PY=${TAGDIR}/bin/devsim
DEVSIM_TCL=${TAGDIR}/bin/devsim_tcl
ANACONDA_PATH=${HOME}/anaconda

#curl -L -O https://github.com/devsim/devsim/releases/download/${TAG}/${TAGTGZ}
#tar xzf ${TAGTGZ} 

mkdir -p bin

cat << EOF > bin/devsim
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\$progname"\`
ANACONDA_PATH=${ANACONDA_PATH}
export DYLD_LIBRARY_PATH=\${ANACONDA_PATH}/lib
export PYTHONHOME=\${ANACONDA_PATH}
# sequential speeds up small examples
export MKL_NUM_THREADS=1
\${curdir}/../${DEVSIM_PY} \$*
EOF
chmod +x bin/devsim

cat << EOF > bin/devsim_tcl
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\$progname"\`
ANACONDA_PATH=${ANACONDA_PATH}
export DYLD_LIBRARY_PATH=\${ANACONDA_PATH}/lib
export TCL_LIBRARY=\${ANACONDA_PATH}/lib/tcl8.6
# sequential speeds up small examples
export MKL_NUM_THREADS=1
\${curdir}/../${DEVSIM_TCL} \$*
EOF
chmod +x bin/devsim_tcl

ln -sf ${TAGDIR}/testing .
ln -sf ${TAGDIR}/examples .

rm -rf run && mkdir run
(cd run && cmake -DDEVSIM_TEST_GOLDENDIR=${BASEDIR}/goldenresults -DDEVSIM_PY_TEST_EXE=${BASEDIR}/bin/devsim -DDEVSIM_TCL_TEST_EXE=${BASEDIR}/bin/devsim_tcl ..)
(cd run && ctest -j2)
