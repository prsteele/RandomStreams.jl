module RandomStreams

export srand, rand, MRG32k3a, MRG32k3aGen, next_stream, AdvanceState 

abstract AbstractRNGStream

include("mrg32k3a.jl")
include("mrg32k3a_types.jl")

end # module
