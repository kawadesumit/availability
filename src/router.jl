using HTTP, availability, Sockets, JSON, Random

const AVAILABILITY_ROUTER = HTTP.Router()

function getSupply(req::HTTP.Request)
        out = availability.Supply("item01", "each", "node01", "onhand", Random.rand(1:1000))
        response = HTTP.Response(200, JSON.json(out))
        # response.setheader("Accept", "application/json")
        # response.setheader("Content-type", "application/json")

        HTTP.setheader(response, "Content-Type" => "application/json")

        return response

end
function createSupply(req::HTTP.Request)
        @show req
        println("Supply created")
        HTTP.Response(200)
end

HTTP.@register(AVAILABILITY_ROUTER, "GET", "/supplies/*", getSupply)
HTTP.@register(AVAILABILITY_ROUTER, "POST", "/supplies", createSupply)


@async HTTP.serve(AVAILABILITY_ROUTER, Sockets.localhost, 8081)