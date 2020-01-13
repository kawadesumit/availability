import JSON

struct Supply
    itemId::String
    uom::String
    nodeId::String
    type::String
    quantity::Int128
end # struct

function deserializeSupplyJSON(req::String)::Supply
    reqDict = JSON.parse(req)
    Supply(reqDict["itemId"], reqDict["uom"], reqDict["nodeId"], reqDict["type"], reqDict["quantity"])
end
