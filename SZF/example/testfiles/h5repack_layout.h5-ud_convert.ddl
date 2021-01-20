HDF5 "ud_convert.h5repack_layout.h5" {
GROUP "/" {
   DATASET "dset1" {
      DATATYPE  H5T_STD_I32LE
      DATASPACE  SIMPLE { ( 40, 20 ) / ( 40, 20 ) }
      STORAGE_LAYOUT {
         CHUNKED ( 4, 8 )
         SIZE 3098 (1.033:1 COMPRESSION)
      }
      FILTERS {
         USER_DEFINED_FILTER {
            FILTER_ID 32017
            COMMENT SZ compressor/decompressor for floating-point data.
            PARAMS { 2 7 8 4 }
         }
      }
      FILLVALUE {
         FILL_TIME H5D_FILL_TIME_IFSET
         VALUE  H5D_FILL_VALUE_DEFAULT
      }
      ALLOCATION_TIME {
         H5D_ALLOC_TIME_INCR
      }
   }
   DATASET "dset2" {
      DATATYPE  H5T_STD_I32LE
      DATASPACE  SIMPLE { ( 40, 20 ) / ( 40, 20 ) }
      STORAGE_LAYOUT {
         CHUNKED ( 4, 8 )
         SIZE 3097 (1.033:1 COMPRESSION)
      }
      FILTERS {
         USER_DEFINED_FILTER {
            FILTER_ID 32017
            COMMENT SZ compressor/decompressor for floating-point data.
            PARAMS { 2 7 8 4 }
         }
      }
      FILLVALUE {
         FILL_TIME H5D_FILL_TIME_IFSET
         VALUE  H5D_FILL_VALUE_DEFAULT
      }
      ALLOCATION_TIME {
         H5D_ALLOC_TIME_INCR
      }
   }
   DATASET "dset3" {
      DATATYPE  H5T_STD_I32LE
      DATASPACE  SIMPLE { ( 40, 20 ) / ( 40, 20 ) }
      STORAGE_LAYOUT {
         CHUNKED ( 4, 8 )
         SIZE 3110 (1.029:1 COMPRESSION)
      }
      FILTERS {
         USER_DEFINED_FILTER {
            FILTER_ID 32017
            COMMENT SZ compressor/decompressor for floating-point data.
            PARAMS { 2 7 8 4 }
         }
      }
      FILLVALUE {
         FILL_TIME H5D_FILL_TIME_IFSET
         VALUE  H5D_FILL_VALUE_DEFAULT
      }
      ALLOCATION_TIME {
         H5D_ALLOC_TIME_INCR
      }
   }
   DATASET "dset4" {
      DATATYPE  H5T_STD_I32LE
      DATASPACE  SIMPLE { ( 40, 20 ) / ( 40, 20 ) }
      STORAGE_LAYOUT {
         CHUNKED ( 4, 8 )
         SIZE 3096 (1.034:1 COMPRESSION)
      }
      FILTERS {
         USER_DEFINED_FILTER {
            FILTER_ID 32017
            COMMENT SZ compressor/decompressor for floating-point data.
            PARAMS { 2 7 8 4 }
         }
      }
      FILLVALUE {
         FILL_TIME H5D_FILL_TIME_IFSET
         VALUE  H5D_FILL_VALUE_DEFAULT
      }
      ALLOCATION_TIME {
         H5D_ALLOC_TIME_INCR
      }
   }
   DATASET "dset_chunk" {
      DATATYPE  H5T_STD_I32LE
      DATASPACE  SIMPLE { ( 40, 20 ) / ( 40, H5S_UNLIMITED ) }
      STORAGE_LAYOUT {
         CHUNKED ( 4, 8 )
         SIZE 3105 (1.031:1 COMPRESSION)
      }
      FILTERS {
         USER_DEFINED_FILTER {
            FILTER_ID 32017
            COMMENT SZ compressor/decompressor for floating-point data.
            PARAMS { 2 7 8 4 }
         }
      }
      FILLVALUE {
         FILL_TIME H5D_FILL_TIME_IFSET
         VALUE  H5D_FILL_VALUE_DEFAULT
      }
      ALLOCATION_TIME {
         H5D_ALLOC_TIME_INCR
      }
   }
   DATASET "dset_compact" {
      DATATYPE  H5T_STD_I32LE
      DATASPACE  SIMPLE { ( 40, 20 ) / ( 40, 20 ) }
      STORAGE_LAYOUT {
         CHUNKED ( 4, 8 )
         SIZE 3105 (1.031:1 COMPRESSION)
      }
      FILTERS {
         USER_DEFINED_FILTER {
            FILTER_ID 32017
            COMMENT SZ compressor/decompressor for floating-point data.
            PARAMS { 2 7 8 4 }
         }
      }
      FILLVALUE {
         FILL_TIME H5D_FILL_TIME_IFSET
         VALUE  H5D_FILL_VALUE_DEFAULT
      }
      ALLOCATION_TIME {
         H5D_ALLOC_TIME_INCR
      }
   }
   DATASET "dset_contiguous" {
      DATATYPE  H5T_STD_I32LE
      DATASPACE  SIMPLE { ( 40, 20 ) / ( 40, 20 ) }
      STORAGE_LAYOUT {
         CHUNKED ( 4, 8 )
         SIZE 3105 (1.031:1 COMPRESSION)
      }
      FILTERS {
         USER_DEFINED_FILTER {
            FILTER_ID 32017
            COMMENT SZ compressor/decompressor for floating-point data.
            PARAMS { 2 7 8 4 }
         }
      }
      FILLVALUE {
         FILL_TIME H5D_FILL_TIME_IFSET
         VALUE  H5D_FILL_VALUE_DEFAULT
      }
      ALLOCATION_TIME {
         H5D_ALLOC_TIME_INCR
      }
   }
}
}
