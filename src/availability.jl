module availability

export Supply, Demand, calculate_Avail

include("model/supply.jl")
include("model/demand.jl")
include("serialization.jl")

function calculate_Avail(supply::Supply, demand::Demand)::Int128
    @info ("calculate availability")
    supply.quantity - demand.quantity
end

end # module
