.. currentmodule:: RandomStreams

***************
 RandomStreams
***************

A random number stream is a sequence of random numbers; multiple
random number streams can be thought of as independent random number
generators. Random number streams can be used to provide many
independent high-quality random number generators, useful for example
when running parallel simulations.

Background
==========

L'Ecuyer et. al describe the notion of streams and substreams in a
random number generator [1]_. We ignore substreams in our
implementation, instead treating each stream as an independent RNG. We
do this because fully supporting both streams and substreams would be
a significant departure from the way Julia (and most contemporary
languages) handle random numbers.

References
==========

.. [1] "An object-oriented random-number package with many long streams
  and substreams", Pierre L'Ecuyer, Richard Simard, E. Jack Chen,
  W. David Kelton. Available
  [here](http://www.iro.umontreal.ca/~lecuyer/myftp/papers/streams00.pdf).

.. [2] "Good parameters and implementations for combined multiple
  recursive random number generators", Pierre L'Ecuyer. Available
  [here](http://www.iro.umontreal.ca/~lecuyer/myftp/papers/combmrg2.ps).
