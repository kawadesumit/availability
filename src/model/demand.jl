import JSON
struct Demand
    itemId::String
    uom::String
    nodeId::String
    type::String
    quantity::Int128
end # struct

function deserializeDemandJSON(req::String)::Demand
    reqDict = JSON.parse(req)
    Demand(reqDict["itemId"], reqDict["uom"], reqDict["nodeId"], reqDict["type"], reqDict["quantity"])
end
