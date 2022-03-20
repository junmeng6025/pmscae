/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * averaging_filter.h
 *
 * Code generation for function 'averaging_filter'
 *
 */

#pragma once

/* Include files */
#include "averaging_filter_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void averaging_filter(const emlrtStack *sp, const emxArray_real_T *x,
                      emxArray_real_T *y);
void averaging_filter_init(void);

/* End of code generation (averaging_filter.h) */
