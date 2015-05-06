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
              << std::endl
              << std::endl
              << "  Computes the seeds for the next three streams "
              << std::endl
              << "and the seeds of its following three substreams."
              << std::endl;
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

  
  RngStream::SetPackageSeed(seed);
  RngStream g ("stream");
  
  unsigned long next_seed [6];

  // Streams
  for ( int j = 0; j < 3; j++ ) {
    RngStream g ("next_stream");
    g.GetState(next_seed);

    for ( int i = 0; i < 6; i++ ) {
      std::cout << next_seed [i] << " ";
    }
    std::cout << std::endl;
  }

  std::cout << std::endl;
  // Substreams
  for ( int j = 0; j < 3; j++ ) {
    g.ResetNextSubstream();
    g.GetState(next_seed);

    for ( int i = 0; i < 6; i++ ) {
      std::cout << next_seed [i] << " ";
    }
    std::cout << std::endl;
  }
}

  
  
    
    
