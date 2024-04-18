#include <iostream>
#include "./include/tensorflow/c/c_api.h"

int main() {
  std::cout << "Hello from TensorFlow C library version " << TF_Version() << std::endl;
  return 0;
}

