using RandomStreams
using Base.Test

generator = MRG32k3aGen([4,5,6,7,8,9])
@test all(generator.nextSeed .== [4,5,6,7,8,9])

rng1 = next_stream(generator)
rng2 = next_stream(generator)

# @test random_U01(rng1) == 4
# @test random_U01(rng2) == 13
