# This is the Makefile.am for the HDF5 Av filter library
# This allows the use of Av quantization on HDF5 datasets


# csz No extra paths necessary since Av filter source currently in plugin code
# AM_CPPFLAGS = -I$(HDF5_ROOT)/include -I$(AV_ROOT)/include

# This is where HDF5 wants us to install plugins
plugindir = @HDF5_PLUGIN_PATH@

# This linker flag specifies libtool version info.
# See http://www.gnu.org/software/libtool/manual/libtool.html#Libtool-versioning
# for information regarding incrementing `-version-info`.
libh5av_la_LDFLAGS = -version-info 0:0:0

# The libh5av library for plugin module
# Build it as shared library
plugin_LTLIBRARIES = libh5av.la
libh5av_la_SOURCES = H5VLpassthru_ext.c
