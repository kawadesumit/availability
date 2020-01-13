module availability

export Supply, Demand, calculate_Avail, greet, deserializeSupplyJSON, deserializeDemandJSON

greet() = "Welcome to Availability Service!"

include("model/supply.jl")
include("model/demand.jl")

function calculate_Avail(supply::Supply, demand::Demand)::Int128
    @info ("calculate availability")
    supply.quantity - demand.quantity
end

end # module
