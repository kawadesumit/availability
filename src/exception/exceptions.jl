struct AvailabilityException <: Exception
    id::Union{Int, String}
    message::String
end
