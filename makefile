makefile
SGX_SDK = /opt/intel/sgxsdk
SGX_MODE = HW
SGX_ARCH = x64

Enclave_C_Files := Enclave.cpp
Enclave_Objects := $(Enclave_C_Files:.cpp=.o)

App_C_Files := App.cpp
App_Objects := $(App_C_Files:.cpp=.o)

Enclave_Name := Enclave
Signed_Enclave_Name := $(Enclave_Name).signed.so
App_Name := app

all: $(Signed_Enclave_Name) $(App_Name)

$(Signed_Enclave_Name): $(Enclave_Objects)
	@$(SGX_SDK)/bin/x64/sgx_edger8r --trusted Enclave.edl --search-path $(SGX_SDK)/include
	@$(CXX) -o $@ $(Enclave_Objects) -L$(SGX_SDK)/lib64 -lsgx_tsgxssl -lsgx_trts -lsgx_tservice -lsgx_tcxx -Wl,--no-undefined -nostartfiles -Wl,--whole-archive -lsgx_tstdcxx -Wl,--no-whole-archive -Wl,--defsym,__ImageBase=0 -Wl,--version-script=Enclave.lds -Wl,-Bstatic -Wl,-Bsymbolic -Wl,--no-undefined -nostdlib -nodefaultlibs

$(App_Name): $(App_Objects)
	@$(SGX_SDK)/bin/x64/sgx_edger8r --untrusted Enclave.edl --search-path $(SGX_SDK)/include
	@$(CXX) -o $@ $(App_Objects) -L$(SGX_SDK)/lib64 -lsgx_urts -lsgx_uae_service

%.o: %.cpp
@$(CXX) -c $< -o $@ -I$(SGX_SDK)/include

clean:
	@rm -f $(Enclave_Objects) $(App_Objects) $(Signed_Enclave_Name) $(App_Name)

.PHONY: all clean

