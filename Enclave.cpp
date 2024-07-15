#include "Enclave_t.h"
#include <string>
#include <cstring>

std::string stored_password;

void store_password(const char* password) {
    stored_password = password;
}

bool validate_password(const char* password) {
    return stored_password == password;
}
