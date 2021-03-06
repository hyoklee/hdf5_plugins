/*
 * Purpose:	The public header file for the async VOL connector.
 */

#ifndef _h5_vol_external_async_native_H
#define _h5_vol_external_async_native_H

/* Characteristics of the async VOL connector */
#define H5VL_ASYNC_NAME        "async"
#define H5VL_ASYNC_VALUE       707           /* VOL connector ID */
#define H5VL_ASYNC_VERSION     0

/* Names for dynamically registered operations */
#define H5VL_ASYNC_DYN_FILE_WAIT        "gov.lbl.async.file.wait"
#define H5VL_ASYNC_DYN_DATASET_WAIT     "gov.lbl.async.dataset.wait"
#define H5VL_ASYNC_DYN_FILE_START       "gov.lbl.async.file.start"
#define H5VL_ASYNC_DYN_DATASET_START    "gov.lbl.async.dataset.start"
#define H5VL_ASYNC_DYN_FILE_DELAY       "gov.lbl.async.file.delay"
#define H5VL_ASYNC_DYN_DATASET_DELAY    "gov.lbl.async.dataset.delay"

#endif /* _h5_vol_external_async_native_H */

