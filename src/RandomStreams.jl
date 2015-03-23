module RandomStreams

export srand, rand, BadMRG32k3a

abstract AbstractRNGStream

include("bad_mrg.jl")

end # module
