using Logging

export shouldlog, min_enabled_level, catch_exceptions

struct AvailabilityLogger <: AbstractLogger
    stream::IO
end

# AvailabilityLogger(stream::IO=stderr, level=Info) = AvailabilityLogger(stream, level, Dict{Any,Int}())

shouldlog(logger::AvailabilityLogger, level, _module, group, id) =
    get(logger.message_limits, id, 1) > 0

min_enabled_level(logger::AvailabilityLogger) = logger.min_level

catch_exceptions(logger::AvailabilityLogger) = false

function handle_message(logger::AvailabilityLogger, level, message, _module, group, id,
                        filepath, line; maxlog=nothing, kwargs...)
    if maxlog !== nothing && maxlog isa Integer
        remaining = get!(logger.message_limits, id, maxlog)
        logger.message_limits[id] = remaining - 1
        remaining > 0 || return
    end
    buf = IOBuffer()
    iob = IOContext(buf, logger.stream)
    levelstr = level == Warn ? "Warning" : string(level)
    msglines = split(chomp(string(message)), '\n')
    println(iob, "┌ ", levelstr, ": ", msglines[1])
    for i in 2:length(msglines)
        println(iob, "│ ", msglines[i])
    end
    for (key, val) in kwargs
        println(iob, "│   ", key, " = ", val)
    end
    println(iob, "└ @ ", something(_module, "nothing"), " ",
            something(filepath, "nothing"), ":", something(line, "nothing"))
    write(logger.stream, take!(buf))
    nothing
end
