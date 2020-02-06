module availability

export Supply, Demand, calculate_Avail, applySupplyAdjusters

include("model/supply.jl")
include("model/demand.jl")
include("serialization.jl")
include("adjuster.jl")
include("exception/exceptions.jl")
# include("router.jl")

function calculate_Avail(supply::Supply, demand::Demand)::Int128
    @info ("calculate availability")
    supply.quantity - demand.quantity
end

end # module
