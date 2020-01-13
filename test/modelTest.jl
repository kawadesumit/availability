using Test

supplyTemp = Supply("item00001", "each", "node001", "onhand", 100)
demandTemp = Demand("item00001", "each", "node001", "allocated", 10)

@testset "Model Tests" begin
    @testset "Supply model" begin
        @test supplyTemp.itemId == "item00001"
        @test supplyTemp.uom == "each"
        @test supplyTemp.nodeId == "node001"
        @test supplyTemp.type == "onhand"
        @test supplyTemp.quantity == 100
    end

    @testset "Demand model" begin
        @test demandTemp.itemId == "item00001"
        @test demandTemp.uom == "each"
        @test demandTemp.nodeId == "node001"
        @test demandTemp.type == "allocated"
        @test demandTemp.quantity == 10
    end

    @testset "Serialization Tests" begin
        supplyString = "{\"itemId\":\"supplyItem00003\",\"uom\":\"each\",\"nodeId\":\"node001\",\"type\":\"onhand\",\"quantity\":100}"
        supply = deserializeJSON(supplyString)
        @info supply

        @test supply.itemId == "supplyItem00003"
        @test supply.uom == "each"
        @test supply.nodeId == "node001"
        @test supply.type == "onhand"
        @test supply.quantity == 100

        demandString = "{\"itemId\":\"demandItem00003\",\"uom\":\"each\",\"nodeId\":\"node001\",\"type\":\"allocated\",\"quantity\":100}"
        demand = deserializeJSON(demandString)
        @info demand

        @test demand.itemId == "demandItem00003"
        @test demand.uom == "each"
        @test demand.nodeId == "node001"
        @test demand.type == "allocated"
        @test demand.quantity == 100

    end
end
