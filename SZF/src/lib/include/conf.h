/**
 *  @file conf.h
 *  @author Sheng Di
 *  @date July, 2017
 *  @brief Header file for the conf.c.
 *  (C) 2016 by Mathematics and Computer Science (MCS), Argonne National Laboratory.
 *      See COPYRIGHT in top-level directory.
 */

#ifndef _Conf_H
#define _Conf_H

#ifdef __cplusplus
extern "C" {
#endif

//conf.c
void updateQuantizationInfo(int quant_intervals);
int SZ_ReadConf(const char* sz_cfgFile);
int SZ_LoadConf(const char* sz_cfgFile);
int checkVersion(char* version);
int computeVersion(int major, int minor, int revision);
int checkVersion2(char* version);

void initSZ_TSC();
unsigned int roundUpToPowerOf2(unsigned int base);
double computeABSErrBoundFromPSNR(double psnr, double threshold, double value_range);
double computeABSErrBoundFromNORM_ERR(double normErr, size_t nbEle);

#ifdef __cplusplus
}
#endif

#endif /* ----- #ifndef _Conf_H  ----- */

