/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * averaging_filter_initialize.c
 *
 * Code generation for function 'averaging_filter_initialize'
 *
 */

/* Include files */
#include "averaging_filter_initialize.h"
#include "_coder_averaging_filter_mex.h"
#include "averaging_filter.h"
#include "averaging_filter_data.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static void averaging_filter_once(void);

/* Function Definitions */
static void averaging_filter_once(void)
{
  mex_InitInfAndNan();
  averaging_filter_init();
}

void averaging_filter_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    averaging_filter_once();
  }
}

/* End of code generation (averaging_filter_initialize.c) */
