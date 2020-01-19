using HTTP, availability, Sockets, JSON, Random, JuliaDB

const AVAILABILITY_ROUTER = HTTP.Router()

supplyDataset = load("temp.dat")

function toSupplyArray(res)
        list = [];

        for i in res
                push!(list, availability.Supply(i.itemId, i.uom, i.nodeId, i.type, i.quantity))
        end

        return list
end

function getSupply(req::HTTP.Request)
        @show req

        itemId = HTTP.URIs.splitpath(req.target)[2]
        @show "itemId: $(itemId)"

        result = filter(r -> isequal(r.itemId, itemId), supplyDataset)
        @show result

        if(length(result) < 1)
                out = Dict("total" => length(result), "supplies" => toSupplyArray(result))
        else
                # res = result[1]
                # out = availability.Supply(res.itemId, res.uom, res.nodeId, res.type, res.quantity)
                out = Dict("total" => length(result), "supplies" => toSupplyArray(result))
        end
        response = HTTP.Response(200, JSON.json(out))
        HTTP.setheader(response, "Content-Type" => "application/json")
        HTTP.setheader(response, "myHeader" => "headerValue1")

        return response

end
function createSupply(req::HTTP.Request)
        @show req
        println("Supply created")
        HTTP.Response(200)
end

HTTP.@register(AVAILABILITY_ROUTER, "GET", "/supplies/*", getSupply)
HTTP.@register(AVAILABILITY_ROUTER, "POST", "/supplies", createSupply)


# @async HTTP.serve(AVAILABILITY_ROUTER, Sockets.localhost, 8081)
HTTP.serve(AVAILABILITY_ROUTER, Sockets.localhost, 8081)
