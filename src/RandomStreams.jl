module RandomStreams

export srand, rand, MRG32k3a, MRG32k3aGen, random_U01, next_stream

abstract AbstractRNGStream

include("mrg32k3a.jl")

end # module
