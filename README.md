PROBLEM STATEMENT
   The problem is to protect sensitive data, such as passwords, from being accessed or tampered with by unauthorized parties. We aim to use Intel Software Guard Extensions (SGX) to create a secure enclave that ensures the confidentiality and integrity of the passwords. The program should allow for securely storing, retrieving, and validating passwords using SGX.

SOLUTION
We  have created a program that uses Intel SGX to securely handle passwords. The program will have the following features:
     *Password Storage:* Store passwords securely within an SGX enclave.
     *Password Retrieval:* Retrieve passwords securely from the enclave.
     *Password Validation:* Validate user-entered passwords against the securely stored passwords.

 PREREQUISITES
* An Intel processor that supports SGX.
*  SGX SDK installed on your development machine.
* asic understanding of C/C++ programming.

PROGRAM STRUCTURE
The program will have the following components:
 *Enclave:* Contains the secure part of the program where passwords are handled.
*Untrusted Application:* The regular part of the application that interacts with the user and communicates with the enclave.

EXPLAINATION
 *Enclave.edl:* Defines the interface of the enclave, specifying which functions are accessible from outside.
 *Enclave.cpp:* Implements the functions defined in the EDL file to store and validate passwords.
 *App.cpp:* Contains the untrusted part of the application, which interacts with the user and calls the enclave functions.
 *Makefile:* Automates the building process of the enclave and the application.
