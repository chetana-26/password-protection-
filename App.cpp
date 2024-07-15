#include <stdio.h>
#include <string>
#include "sgx_urts.h"
#include "Enclave_u.h"

#define ENCLAVE_FILE "Enclave.signed.so"

// Function prototypes
void storePassword(sgx_enclave_id_t eid, const char* password);
bool validatePassword(sgx_enclave_id_t eid, const char* password);

int main() {
    sgx_enclave_id_t eid;
    sgx_status_t ret = sgx_create_enclave(ENCLAVE_FILE, SGX_DEBUG_FLAG, NULL, NULL, &eid, NULL);
    if (ret != SGX_SUCCESS) {
        printf("Failed to create enclave.\n");
        return -1;
    }

    const char* password = "securepassword123";
    storePassword(eid, password);

    if (validatePassword(eid, password)) {
        printf("Password validated successfully.\n");
    } else {
        printf("Password validation failed.\n");
    }

    sgx_destroy_enclave(eid);
    return 0;
}
void storePassword(sgx_enclave_id_t eid, const char* password) {
    sgx_status_t ret = store_password(eid, password);
    if (ret != SGX_SUCCESS) {
        printf("Failed to store password.\n");
    }
}

bool validatePassword(sgx_enclave_id_t eid, const char* password) {
    sgx_status_t ret;
    bool result;
    ret = validate_password(eid, password, &result);
    if (ret != SGX_SUCCESS) {
        printf("Failed to validate password.\n");
    }
    return result;
}
