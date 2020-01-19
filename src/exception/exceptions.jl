struct AvailabilityException <: Exception
    id::Union{Int, String}
    message::String
end

Base.showerror(io::IO, e::AvailabilityException) =
    print(io, "id=\"$(e.id)\", message=\"$(e.message)\" happened")
