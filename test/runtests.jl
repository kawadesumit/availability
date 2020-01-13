# print("Running tests...")
@info "Running tests..."
using availability, Test

# @warn "warning !!!"
# @debug "debug !!!"

message = availability.greet()
@test "Welcome to Availability Service!" == message

include("modelTest.jl")
