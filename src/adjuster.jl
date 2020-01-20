abstract type Adjuster{T <: Union{Supply, Demand}} end

abstract type SupplyAdjuster{Supply <: Adjuster} end
abstract type DemandAdjuster{Demand <: Adjuster} end

struct SafetyStockAdjuster2{SupplyAdjuster}
    quantity::Int

    SafetyStockAdjuster2{SupplyAdjuster}(quantity) = new(quantity)
end

struct DemandValueAdjuster{Demand} <: DemandAdjuster{Demand}
    quantity::Int
end

varSupplyAdjusters = [
    SafetyStockAdjuster2{SupplyAdjuster}(20), 
    SafetyStockAdjuster2{SupplyAdjuster}(20)]

function applySupplyAdjusters(adj::Array)
    # println("start - Applying SafetyStock Adjuster $(adj)")

    out = []

    for val in adj
        for adjuster in varSupplyAdjusters
            val -= adjuster.quantity
        end
        push!(out, val)
    end

    # println("End - Applying SafetyStock Adjuster $(out)")

    return out
end

function applyDemandAdjusters(adj::DemandValueAdjuster)
    println("Applying SafetyStock Adjuster")
end
