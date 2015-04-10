* Test case generation

We compare our implementation to the C++ implementation by Pierre
L'Ecuyer. His code, `RngStream.cpp` and `RngStream.h`, is included
here for reference and completeness, but falls under its own license
(see `RngStream.cpp`).

The file `stream.cpp` defines a simple interface to L'Ecuyer's
implementation. Namely, it takes as command-line arguments the 6
integer seeds with which to create a generator, and then generates the
first 10000000 random numbers. It reports the sum of these numbers
along with the first and last 10 such numbers.
