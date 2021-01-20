#!/usr/bin/tcsh
set path=(/scr/hyoklee/src/spack-hyoklee/bin/ $path)
source /scr/hyoklee/src/spack-hyoklee/share/spack/setup-env.csh
spack load hdf5-cmake
set p="`spack find --paths hdf5-cmake | tail  -1 | cut -d' ' -f 3-`"
setenv HDF5_HOME $p
set pl="/scr/hyoklee/src/hdf5_plugins"

# Most static tests will fail for static h5repack.
cd $pl/BITGROOM/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
./testCM.sh

cd $pl/BLOSC/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
./testCM.sh

cd $pl/BSHUF/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
./testCM.sh

cd $pl/BZIP2/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
./test.sh
./testCM.sh

cd $pl/JPEG/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
./testCM.sh

cd $pl/LZ4/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
./testCM.sh

cd $pl/LZF/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
./testCM.sh

cd $pl/MAFISC/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
# ./testCM.sh

cd $pl/SZF/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
./testCM.sh

cd $pl/ZFP/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
./testCM.sh

cd $pl/ZSTD/example/test/
rm h5ex* *.h5 *.out* *.err *.dll 
# ./test.sh
./testCM.sh
