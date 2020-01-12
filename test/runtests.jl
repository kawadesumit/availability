print("Running tests...")

using availability, Test

message = availability.greet()
@test "Welcome to Availability Service!" == message
