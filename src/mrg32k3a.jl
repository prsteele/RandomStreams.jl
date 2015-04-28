const m1 = Int64(2^32 - 209)
const m2 = Int64(2^32 - 22853)
const a12 = Int64(1403580)
const a13 = Int64(-810728)
const a21 = Int64(527612)
const a23 = Int64(-1370589)
const norm = 1.0 / (1 + m1)
const two17 = Int64(131072)
const two53 = Int64(9007199254740992)
#const fact = Float64(1/2^24)

const A1p0 =  [  0     1     0 ;
                 0     0     1 ;
                 a13   a12   0 ]

const A2p0 =  [  0     1   0   ;
                 0     0   1   ;
                 a23   0   a21 ]

const A1p76 =  [   82758667  1871391091  4127413238 ;
                 3672831523    69195019  1871391091 ;
                 3672091415  3528743235    69195019 ]

const A2p76 =  [ 1511326704  3759209742  1610795712 ;
                 4292754251  1511326704  3889917532 ;
                 3859662829  4292754251  3708466080 ]

const A1p127 = [ 2427906178  3580155704   949770784 ;
                  226153695  1230515664  3580155704 ;
                 1988835001   986791581  1230515664 ]

const A2p127 = [ 1464411153   277697599  1610723613 ;
                   32183930  1464411153  1022607788 ; 
                 2824425944    32183930  2093834863 ]
      
const InvA1  = [  184888585           0  1945170933 ;
                          1           0           0 ;
                          0           1           0 ]

const InvA2 =  [          0   360363334  4225571728 ;
                          1           0           0 ;
                          0           1           0 ]
       

function checkseed(x::Vector{Int})
    return length(x) == 6     &&
           all(x[1:6] .>= 0)  &&
           all(x[1:3] .< m1)  &&
           all(x[4:6] .< m2)  &&
          ~all(x[1:3] == 0)   &&
          ~all(x[4:6] == 0)
end

type MRG32k3a <: AbstractRNG
    Cg::Vector{Int64}  # the current state of the RNG
    Bg::Vector{Int64}  # the start point of the current substream
    Ig::Vector{Int64}  # the start point of the current stream
    
    function MRG32k3a(x::Vector{Int})
        @assert(checkseed(x))
        new(copy(x),copy(x),copy(x))
    end
end    


string(rng::MRG32k3a) =  string("Full state of RNG Stream:\n",
                                "Cg = ",rng.Cg,"\n",
                                "Bg = ",rng.Bg,"\n",
                                "Ig = ",rng.Ig,"\n")

get_state(rng::MRG32k3a) = rng.Cg

# produces a random number with 32 bits of precision

function rand(rng::MRG32k3a)
    
    p1::Int64 = (a12 * rng.Cg[2] + a13 * rng.Cg[1]) % m1
    p1 += p1 < 0 ? m1 : 0 

    rng.Cg[1] = rng.Cg[2]
    rng.Cg[2] = rng.Cg[3]
    rng.Cg[3] = p1

    p2::Int64 = (a21 * rng.Cg[6] + a23 * rng.Cg[4]) % m2
    p2 += p2 < 0 ? m2 : 0

    rng.Cg[4] = rng.Cg[5]
    rng.Cg[5] = rng.Cg[6]
    rng.Cg[6] = p2

    u::Float64 = p1 > p2 ? (p1 - p2) * norm : (p1 + m1 - p2) * norm
end

function srand(rng::MRG32k3a,x::Vector{Int})
    @assert(checkseed(x))
    for i = 1:6
        rng.Cg[i] = rng.Bg[i] = rng.Ig[i] = x[i]     
    end
end

function reset_stream(rng::MRG32k3a)
    for i = 1:6
        rng.Cg[i] = rng.Bg[i] = rng.Ig[i]
    end
end

function reset_substream(rng::MRG32k3a)
    for i = 1:6
        rng.Cg[i] = rng.Bg[i]
    end
end

function next_substream(rng::MRG32k3a)
    rng.Bg[1:3] = MatVecModM(A1p76,rng.Bg[1:3],m1)
    rng.Bg[4:6] = MatVecModM(A1p76,rng.Bg[4:6],m2)
    for i = 1:6
        rng.Cg[i] = rng.Bg[i]
    end
end
        
    
 
############################################################
      
type MRG32k3aGen <: AbstractRNGStream
    nextSeed::Vector{Int64}

    function MRG32k3aGen(x::Vector{Int})
        @assert(checkseed(x))
        new(x)
    end

end

string(rng_gen::MRG32k3aGen) = string("Seed for next MRG32k3a generator:\n",rng_gen.nextSeed)

get_state(rng_gen::MRG32k3aGen) = rng_gen.nextSeed

function srand(rng_gen::MRG32k3aGen,seed::Vector{Int})
    @assert(checkseed(x))
    for i = 1:6
        rng_gen.nextSeed[i] = x[i]
    end
    return true
end


function next_stream(rng_gen::MRG32k3aGen)
    rng = MRG32k3a(copy(rng_gen.nextSeed))
    
    rng_gen.nextSeed[1:3] = MatVecModM(A1p127,rng_gen.nextSeed[1:3],m1)
    rng_gen.nextSeed[4:6] = MatVecModM(A2p127,rng_gen.nextSeed[4:6],m2)
    
    return rng
end

#Return (a*s + c) % m, all must be < 2^35
function MultModM (a::Int64, s::Int64, c::Int64, m::Int64)
    if abs(a * Float64(s) + c) < two53
        v = a*s + c
    else
        a1 = a ÷ two17
        a -= a1 * two17
        v  = a1 * s
        v %= m
        v  = v * two17 + a * s + c
    end
    v %= m
    # in case v < 0
    v += (v < 0) ? m : 0
    return v
end

#Computes A*s % m, assumes that abs(s[i]) < m
function MatVecModM(A::Array{Int64,2},s::Array{Int64,1}, m::Int64)
    @assert(size(A)==(3,3))
    @assert(size(s)==(3,))

    v = [0, 0, 0]

    for i = 1:3
        for j = 1:3
            v[i] = MultModM(A[i,j], s[j], v[i], m)
        end
    end

    return v
end

#Computes matrix A*B % m, assumes that abs(s[i]) < m
function MatMatModM(A::Array{Int64,2}, B::Array{Int64,2}, m::Int64)
    @assert(size(A)==(3,3))
    @assert(size(B)==(3,3))

    C = diagm([0,0,0])

    for i = 1:3
        C[:,i] = MatVecModM(A,B[:,i],m)
    end

    return C
end

#Computes the matrix A^(2^e) % m
function MatTwoPowModM(A::Array{Int64,2}, e::Int64, m::Int64)
    @assert(size(A)==(3,3))

    B = A
    for i = 1:e
        B = MatMatModM(B, B, m)
    end
    
    return B    
end

#Computes the matrix  (A^n % m)
function MatPowModM(A::Array{Int64,2}, n::Int64, m::Int64)
    W = A
    B = diagm([1,1,1])

    while n > 0
        if ( n % 2 == 1 ) 
            B = MatMatModM(W, B, m)
        end
        W = MatMatModM(W, W, m)
        n ÷= 2
    end
    return B
end

function AdvanceState!(rng::MRG32k3a, e::Int64, c::Int64)
    if c >= 0
        C1 = MatPowModM(A1p0,c,m1)
        C2 = MatPowModM(A2p0,c,m2)
    else
        C1 = MatPowModM(InvA1,-c,m1)
        C2 = MatPowModM(InvA2,-c,m2)
    end

    if e > 0
        B1 = MatTwoPowModM(A1p0,e,m1)
        B2 = MatTwoPowModM(A2p0,e,m2)
    elseif e < 0
        B1 = MatTwoPowModM(InvA1,-e,m1)
        B2 = MatTwoPowModM(InvA2,-e,m2)
    end
    
    if ~(e == 0)
        C1 = MatMatModM(B1,C1,m1)
        C2 = MatMatModM(B2,C2,m1)
    end

    rng.Cg[1:3] = MatVecModM(C1,rng.Cg[1:3],m1) 
    rng.Cg[4:6] = MatVecModM(C2,rng.Cg[4:6],m2) 
end

