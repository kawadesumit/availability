using Test

supplyTemp = Supply("item00001", "each", "node001", "onhand", 100)
demandTemp = Demand("item00001", "each", "node001", "allocated", 10)


@testset "Serialization Tests" begin

    @testset "Supply test" begin
        supplyString = "{\"itemId\":\"supplyItem00003\",\"uom\":\"each\",\"nodeId\":\"node001\",\"type\":\"onhand\",\"quantity\":100}"
        supply = deserialize(supplyString, Supply)
        @info supply

        @test supply.itemId == "supplyItem00003"
        @test supply.uom == "each"
        @test supply.nodeId == "node001"
        @test supply.type == "onhand"
        @test supply.quantity == 100
    end

    @testset "Demand test" begin
        demandString = "{\"itemId\":\"demandItem00003\",\"uom\":\"each\",\"nodeId\":\"node001\",\"type\":\"allocated\",\"quantity\":100}"
        demand = deserialize(demandString, Demand)
        @info demand

        @test demand.itemId == "demandItem00003"
        @test demand.uom == "each"
        @test demand.nodeId == "node001"
        @test demand.type == "allocated"
        @test demand.quantity == 100
    end

    @testset "Not supported" begin
        inputString = "{\"itemId\":\"demandItem00003\",\"uom\":\"each\",\"nodeId\":\"node001\",\"type\":\"allocated\",\"quantity\":100}"
        @test_throws "Not Supported" deserialize(inputString, Set)
    end

end
