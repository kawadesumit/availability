using Test

supplyTemp = Supply("item00001", "each", "node001", "onhand", 100)

@testset "Supply model" begin
    @test supplyTemp.itemId == "item00001"
    @test supplyTemp.uom == "each"
    @test supplyTemp.nodeId == "node001"
    @test supplyTemp.type == "onhand"
    @test supplyTemp.quantity == 100
end

demandTemp = Demand("item00001", "each", "node001", "allocated", 10)

@testset "Demand model" begin
    @test demandTemp.itemId == "item00001"
    @test demandTemp.uom == "each"
    @test demandTemp.nodeId == "node001"
    @test demandTemp.type == "allocated"
    @test demandTemp.quantity == 10
end
