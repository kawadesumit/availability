import JSON

export deserialize

function deserialize(req::String, type)
    if type == Supply
        deserializeSupply(req)
    elseif type == Demand
        deserializeDemand(req)
    else
        throw("Not Supported")
    end
end

# TODO mapping using reflection aka fields in stead of explicit mapping

function deserializeSupply(req::String)::Supply
    reqDict = JSON.parse(req)
    Supply(
        reqDict["itemId"],
        reqDict["uom"],
        reqDict["nodeId"],
        reqDict["type"],
        reqDict["quantity"])
end

function deserializeDemand(req::String)::Demand
    reqDict = JSON.parse(req)
    Demand(
        reqDict["itemId"],
        reqDict["uom"],
        reqDict["nodeId"],
        reqDict["type"],
        reqDict["quantity"])
end
