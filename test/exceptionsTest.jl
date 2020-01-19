using Test

@testset "Availability Exceptions" begin
    ex = AvailabilityException(1, "supply error")
    @test 1 == ex.id
    @test "supply error" == ex.message

    ex1 = AvailabilityException("EX001", "demand error")
    @test "EX001" == ex1.id
    @test "demand error" == ex1.message

end
