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
        # @show req

        itemId = HTTP.URIs.splitpath(req.target)[2]
        # @show "itemId: $(itemId)"

        result = filter(r -> isequal(r.itemId, itemId), supplyDataset)
        # @show result

        out = Dict(
                "totalRecords" => length(result),
                "totalQuantity" => ((t -> select(t, :quantity)) ∘ (t -> filter(r -> isequal(r.itemId, itemId), t)))(result) |> sum,
                "supplies" => toSupplyArray(result))

        if(length(result) < 1)
                status = 404
        else
                status = 200
        end

        response = HTTP.Response(status, JSON.json(out))
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
