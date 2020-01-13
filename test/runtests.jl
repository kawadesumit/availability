# print("Running tests...")
@info "Running tests..."
using availability, Test

# @warn "warning !!!"
# @debug "debug !!!"

message = greet()
@test "Welcome to Availability Service!" == message

include("modelTest.jl")

@testset "Availability Calculations" begin
    @test calculate_Avail(supplyTemp, demandTemp) == 90
    @inferred String calculate_Avail(supplyTemp, demandTemp)

    @test_broken calculate_Avail(supplyTemp, demandTemp) == 91
    @test_skip calculate_Avail(supplyTemp, demandTemp) == 91

    # validates the log statements generated by function call
    @test (@test_logs (:info, "calculate availability") calculate_Avail(supplyTemp, demandTemp)) == 90

end
