module RandomStreams

using base.Random

abstract AbstractRNGStream

type BadMRG32k3a <: Union(AbstractRNGStream, AbstractRNG)
    x::Int64

    function BadMRG32k3a(x::Int64)
        new(x)
    end
end

#next_rng(rsg::AbstractRNGStream, seed, ::AbstractRNG) = 0
#reseed_stream(rsg::AbstractRNGStream, seed, ::AbstractRNGStream)

#
# AbstractRNGStream implementation
#
function next_rng(self::BadMRG32k3a, ::BadMRG32k3a)
    BadMRG32k3a(self.x + 1)
end

function reseed_stream(self::BadMRG32k3a, seed::Int64, ::BadMRG32k3a)
    BadMrg32k3a(seed)
end

#
# AbstractRNG implementation
#

function srand(self::BadMRG32k3a, seed::Int64, ::BadMRG32k3a)
    BadMRG32k3a(seed)
end

function rand(self::BadMRG32k3a, T::Type)
    self.x
end
