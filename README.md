# macOS Tests

Please see ``preinstall.sh`` for installing prerequisites from the Anaconda Python distribution.

Please see ``travis_tests.sh`` for an example of how to setup and run the tests.

Results are sensitive to the CPU and system libraries that may be installed on your Mac OS X computer.

All tests pass on Mac OS X 10.13 on a Macbook Pro 2014.

For example:

```
cd devsim_tests_macos_gcc_x86_x64
source preinstall.sh
tar xzvf devsim_macos_v1.7.0.tgz
bash travis_tests.sh v1.7.0
```
