using JSON

JSON.json([1, 2])

v1 = Dict([("t", 1), ("w", 1)])
JSON.json(v1)

v2 = Dict("a1"=>1, "a2"=>2, "a3"=>Dict("b"=>2))
s = JSON.json(v2)

# JSON.json(Supply("item00003", "each", "node001", "onhand", 100))

supplyString = "{\"itemId\":\"supplyItem00003\",\"uom\":\"each\",\"nodeId\":\"node001\",\"type\":\"onhand\",\"quantity\":100}"
@time supply = deserializeSupplyJSON(supplyString)
@info supply

demandString = "{\"itemId\":\"demandItem00003\",\"uom\":\"each\",\"nodeId\":\"node001\",\"type\":\"onhand\",\"quantity\":100}"
@time demand = deserializeDemandJSON(demandString)
@info demand
