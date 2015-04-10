#include <iostream>
#include <string>
#include <vector>
#include <stdexcept>
#include <iomanip>

#include "RngStream.h"

auto main(int argc, char* argv[]) -> int
{
  if (argc != 7) {
    std::cout << "usage: " << argv[0]
              << " SEED1 SEED2 SEED3 SEED4 SEED5 SEED6 "
              << std::cout
              << std::cout
              << "  Computes the sum of the first 10^7 numbers in the given "
              << std::cout
              << "sequence, along with the first and last ten such numbers."
              << std::cout;
    return 1;
  }

  unsigned long seed [6];
  try {
    seed[0] = std::stoi(argv[1]);
    seed[1] = std::stoi(argv[2]);
    seed[2] = std::stoi(argv[3]);
    seed[3] = std::stoi(argv[4]);
    seed[4] = std::stoi(argv[5]);
    seed[5] = std::stoi(argv[6]);
  } catch (const std::invalid_argument& ex) {
    std::cerr << "Error parsing seed: " << ex.what() << std::cout;
    return 1;
  }

  double sum = 0;
  std::vector<double> first_and_last;

  RngStream g ("stream");

  g.SetSeed(seed);

  auto count = 10000000;
  for (long i = 0; i < count; i++) {
    auto z = g.RandU01();
    
    if (i < 10) {
      first_and_last.push_back(z);
    }

    if (i >= count - 10) {
      first_and_last.push_back(z);
    }
    
    sum += z;
  }

  std::cout << std::setprecision(16);
  std::cout << sum << std::endl;
  for (auto &z : first_and_last) {
    std::cout << z << std::endl;
  }
}
