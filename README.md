# `RandomStreams`

This repository contains the `RandomStreams` package for the Julia
language.

# Introduction

We offer an implementation of the MRG32k3a random number generator
proposed by Pierre L'Ecuyer; see [1] for a good overview and
motivation for the project, and [2], [3], and [4] for detailed
references.

# References

- [1] "An object-oriented random-number package with many long streams
  and substreams", Pierre L'Ecuyer, Richard Simard, E. Jack Chen,
  W. David Kelton.
  [Paper](http://www.iro.umontreal.ca/~lecuyer/myftp/papers/streams00.pdf).

- [2] "Good parameters and implementations for combined multiple
  recursive random number generators", Pierre L'Ecuyer.
  [Paper](http://www.iro.umontreal.ca/~lecuyer/myftp/papers/combmrg2.ps).

- [3] "Good Parameter Sets for Combined Multiple Recursive Random
  Number Generators", Pierre L'Ecuyer.
  [Paper](http://pubsonline.informs.org/doi/abs/10.1287/opre.47.1.159)
  and [C
  code](http://www.iro.umontreal.ca/%7Elecuyer/myftp/papers/combmrg2.c).

- [4] "An Objected-Oriented Random-Number Package with Many Long
  Streams and Substreams", P. L'Ecuyer, R. Simard, E. J. Chen, and
  W. D. Kelton, Operations Research, 50, 6 (2002),
  1073--1075. [Paper](http://pubsonline.informs.org/doi/abs/10.1287/opre.50.6.1073.358).