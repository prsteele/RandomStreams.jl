module RandomStreams

export srand, rand, MRG32k3a, MRG32k3aGen, next_stream, next_substream, reset_stream, reset_substream, get_state, advance_state!

abstract AbstractRNGStream

include("mrg32k3a.jl")
include("mrg32k3a_types.jl")

end # module
