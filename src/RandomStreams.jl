module RandomStreams

import Base.Random
import Base: rand,srand,show

export MRG32k3a, MRG32k3aGen, next_stream, next_substream!, reset_stream!, reset_substream!, get_state, advance_state!

abstract type AbstractRNGStream end

include("mrg32k3a.jl")
include("mrg32k3a_types.jl")

end # module
