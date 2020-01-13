module availability

export Supply, Demand

greet() = "Welcome to Availability Service!"

include("model/supply.jl")
include("model/demand.jl")

end # module
