# This is the Makefile.am for the HDF5 Cv filter library
# This allows the use of Cv quantization on HDF5 datasets
#
# Charlie Zender 9/12/20

# csz No extra paths necessary since Cv filter source currently in plugin code
# AM_CPPFLAGS = -I$(HDF5_ROOT)/include -I$(CV_ROOT)/include

# This is where HDF5 wants us to install plugins
plugindir = @HDF5_PLUGIN_PATH@

# This linker flag specifies libtool version info.
# See http://www.gnu.org/software/libtool/manual/libtool.html#Libtool-versioning
# for information regarding incrementing `-version-info`.
libh5cv_la_LDFLAGS = -version-info 0:0:0

# The libh5cv library for plugin module
# Build it as shared library
plugin_LTLIBRARIES = libh5cv.la
libh5cv_la_SOURCES = H5VLpassthru_ext.c
