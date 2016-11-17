export CC=icc

rm -rf lib include
mkdir lib
mkdir include

# SPRNG
# gcc-2.95 needed
#wget http://sprng.cs.fsu.edu/Version2.0/sprng2.0b.tar.gz
tar xzvf sprng2.0b.tar.gz
\cp -f  ifort/make.CHOICES sprng2.0
\cp  ifort/make.IFORT sprng2.0/SRC
cd sprng2.0
make -B
\cp lib/libsprng.a ../lib
\cp include/*.h ../include
cd ..
rm -rf sprng2.0

# cfitsio
# g77 ou f77 needed by configure to set up the fotran wrapper in Makefile
tar xzvf cfitsio3030.tar.gz
cd cfitsio
./configure
make
\cp libcfitsio.a ../lib
cd ..
rm -rf cfitsio

# voro++
tar xzvf voro++-0.4.6.tar.gz
\cp -f  ifort/config.mk voro++-0.4.6
cd voro++-0.4.6
make
\cp src/libvoro++.a ../lib
mkdir -p ../include/voro++
\cp src/*.hh ../include/voro++/
cd ..
rm -rf voro++-0.4.6

# Numerical recipes
mkdir lib/nr lib/nr/eq_diff lib/nr/spline lib/nr/sort
cd nr
./compile_ifort.sh
\cp libnr.a *.mod ../lib/nr
\cp eq_diff/libnr_eq_diff.a eq_diff/*.mod ../lib/nr/eq_diff
\cp spline/libnr_splin.a ../lib/nr/spline
\cp sort/libnr_sort.a ../lib/nr/sort
./clean.sh
cd ..

mkdir -p $MCFOST_INSTALL/include
\cp -r include/* $MCFOST_INSTALL/include
mkdir -p $MCFOST_INSTALL/lib/ifort
\cp -r lib/* $MCFOST_INSTALL/lib/ifort