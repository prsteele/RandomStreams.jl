include("bad_mrg.jl")

const m1 = float64(2^32 - 209)
const m2 = float64(2^32 - 22853)
const a12 = float64(1403580)
const a13 = float64(-810728)
const a21 = float64(527612)
const a23 = float64(-1370589)
const norm = 2.328306549295727688e-10

const A1p0 =  [  0.0   1.0   0.0 ;
                 0.0   0.0   1.0 ;
                 a13   a12   0.0 ]

const A2p0 =  [  0.0   1.0   0.0 ;
                 0.0   0.0   1.0 ;
                 a23   0.0   a21 ]

const A1p76 = [    82758667.0  1871391091.0  4127413238.0 ;
                 3672831523.0    69195019.0  1871391091.0 ;
                 3672091415.0  3528743235.0    69195019.0 ]

const A2p76 = [  1511326704.0  3759209742.0  1610795712.0 ;
                 4292754251.0  1511326704.0  3889917532.0 ;
                 3859662829.0  4292754251.0  3708466080.0 ]

const A1p127 = [ 2427906178.0  3580155704.0   949770784.0 ;
                  226153695.0  1230515664.0  3580155704.0 ;
                 1988835001.0   986791581.0  1230515664.0 ]

const A2p127 = [ 1464411153.0   277697599.0  1610723613.0 ;
                   32183930.0  1464411153.0  1022607788.0 ; 
                 2824425944.0    32183930.0  2093834863.0 ]
      
const InvA1  = [  184888585.0           0.0  1945170933.0 ;
                          1.0           0.0           0.0 ;
                          0.0           1.0           0.0 ]

const InvA2 =  [          0.0   360363334.0  4225571728.0 ;
                          1.0           0.0           0.0 ;
                          0.0           1.0           0.0 ]
       

type MRG32k3a
    state::Vector{Int64}
    
    function MRG32k3a(x::Vector{Int64})
        new(x)
    end
end      
      
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

    function next_stream(self::MRG32k3aGeln, ::MRG23k3a)
        rng = MRG23k3a(nextseed)
        
        # need to adjust for numerical accuracy
        nextSeed[1:3] = (A1p127 * nextSeed[1:3]) % m1
        nextSeed[4:6] = (A2p127 * nextSeed[4:6]) % m2

        return rng
    end

end
