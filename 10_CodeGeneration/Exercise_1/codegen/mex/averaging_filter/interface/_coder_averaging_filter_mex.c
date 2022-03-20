/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_averaging_filter_mex.c
 *
 * Code generation for function '_coder_averaging_filter_mex'
 *
 */

/* Include files */
#include "_coder_averaging_filter_mex.h"
#include "_coder_averaging_filter_api.h"
#include "averaging_filter_data.h"
#include "averaging_filter_initialize.h"
#include "averaging_filter_terminate.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void averaging_filter_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[1])
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *outputs[1];
  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 1, 4,
                        16, "averaging_filter");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 16,
                        "averaging_filter");
  }

  /* Call the function. */
  averaging_filter_api(prhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&averaging_filter_atexit);

  /* Module initialization. */
  averaging_filter_initialize();

  /* Dispatch the entry-point. */
  averaging_filter_mexFunction(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  averaging_filter_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_averaging_filter_mex.c) */
