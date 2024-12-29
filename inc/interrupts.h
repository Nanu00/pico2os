#include <stdint.h>

void GenericExceptionHandler(void);

void SVCallHandler(uint32_t svc_num, uint32_t argc, void* argv);
