.. currentmodule:: RandomStreams

***************
 RandomStreams
***************

A random number stream is a sequence of random numbers; multiple
random number streams can be thought of as independent random number
generators. Random number streams can be used to provide many
independent high-quality random number generators, useful for example
when running parallel simulations.

Introduction
============

A simple random number generator is a *linear congruential generator*
(LCG). An LCG computes a series of numbers via the recursion

.. math::

  x_i = a x_{i - 1} mod m

where the variables :math:`a` and :math:`m` are carefully
chosen. Although LCGs are not in general a good source of random
numbers, they will be useful as an example. The recursion chooses
:math:`x_0` as a *seed* for the generator.

Suppose we want to run two instances of a simulation. How can we get
two sources of random numbers? Imagine we pick a seed and then run the
LCG for a very large number of iterations, and record the final random
number as a new seed. We can now run one simulation using the first
seed, and the second simulation using the second seed. Note that this
can even be done in parallel, since there is no shared computation. We
say that these two sequences of random numbers are *streams* of random
numbers.

If we have a computationally efficient way to jump ahead very large
distances inside a single random number generator, we can then create
(potentially many) random number generators that can be used for
different simulations. Note that we need to jump ahead 'very far' to
avoid using the same sequence of numbers twice; if we jump ahead one
million numbers but a simulation uses two million numbers, two
different simulations will share one million numbers.

While the notion of jumping ahead in a random number generator to
create multiple streams of random numbers is useful, the statistical
properties of the resulting streams are not well-understood in
general. To overcome this we need a random number generator with
well-understood streams and a very large period, for example the
MRG32k3a generator described in [2]_.

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
