const m1 = float64(2^32 - 209)
const m2 = float64(2^32 - 22853)
const a12 = float64(1403580)
const a13 = float64(-810728)
const a21 = float64(527612)
const a23 = float64(-1370589)
const norm = 2.328306549295727688e-10

type MRG32k3aGen
    state::Vector{Int64}

    function MRG32k3aGen(x::Vector{Int64})
        @assert(length(x) == 6)
        @assert(all(x[1:3] .> 0))
        @assert(all(x[1:3] .< m1))
        @assert(all(x[4:6] .> 0))
        @assert(all(x[4:6] .< m2))

        new(x)
    end
end
