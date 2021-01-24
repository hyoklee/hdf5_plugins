# This is the Makefile.am for the HDF5 Pv filter library
# This allows the use of Pv quantization on HDF5 datasets
#
# Charlie Zender 9/12/20

# csz No extra paths necessary since Pv filter source currently in plugin code
# AM_CPPFLAGS = -I$(HDF5_ROOT)/include -I$(PV_ROOT)/include

# This is where HDF5 wants us to install plugins
plugindir = @HDF5_PLUGIN_PATH@

# This linker flag specifies libtool version info.
# See http://www.gnu.org/software/libtool/manual/libtool.html#Libtool-versioning
# for information regarding incrementing `-version-info`.
libh5pv_la_LDFLAGS = -version-info 0:0:0

# The libh5pv library for plugin module
# Build it as shared library
plugin_LTLIBRARIES = libh5pv.la
libh5pv_la_SOURCES = H5VLpassthru_ext.c
