#ifndef __c4_SITL_gerador_codigo_h__
#define __c4_SITL_gerador_codigo_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#include <stddef.h>
#ifndef typedef_SFc4_SITL_gerador_codigoInstanceStruct
#define typedef_SFc4_SITL_gerador_codigoInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c4_sfEvent;
  boolean_T c4_isStable;
  boolean_T c4_doneDoubleBufferReInit;
  uint8_T c4_is_active_c4_SITL_gerador_codigo;
  real32_T *c4_throttle1;
  real32_T *c4_header;
  real32_T (*c4_throttle_cmd)[18];
  real32_T *c4_throttle2;
  real32_T *c4_throttle3;
  real32_T *c4_throttle4;
} SFc4_SITL_gerador_codigoInstanceStruct;

#endif                                 /*typedef_SFc4_SITL_gerador_codigoInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c4_SITL_gerador_codigo_get_eml_resolved_functions_info
  (void);

/* Function Definitions */
extern void sf_c4_SITL_gerador_codigo_get_check_sum(mxArray *plhs[]);
extern void c4_SITL_gerador_codigo_method_dispatcher(SimStruct *S, int_T method,
  void *data);

#endif
