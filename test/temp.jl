using availability

println(repeat("-", 50))
for i in (Int8, Int16, Int32, Int64,Int128)
    println("$i range = $(typemin(i)), $(typemax(i))")
end
println(repeat("-", 50))


for i in 1:1000
    a = Char(i)
    length(a) > 0 ? print("$(a) : ") : print("NOT_FOUND");break
end

a = """hello !!
I am Sumit Kawade.
I am learning "Julia language".
I find it easier for my next growth.
"""

b = a[1:10]
c = a[12:50]
d = replace(a, Pair(" ", "             "))

e = a[end - 50: end]

first(a, 10)

firstindex(a)
lastindex(a)

f = collect(a)

sizeof(f)

@. length(f)

g = "f: $f"

h = sort([1, 3 , 5, 2, 6, 2, 3 , 7])

i = sort(["abc", "bcd", "cde", "abd"])

j = findall("I", a)

k = join([1, 2, 3, 4, 5], " \n", "\n$(repeat("a", 10))")

codeunit(a, 1)

length(a)

nextind(a, 1, 4)

l = b"$a"

m = (4 ,2, 4)
m1 = m[2]
length(m)
sizeof(m)

sort(collect(m))
for i in m; println(i); end

n = (x=1, y=2, z=3, a=1, b=2)

typeof(n)

keys(n)

for a in keys(n)
    println("$a = $(n[a])")
end

function getBeforeAfter(in::NamedTuple, indx::Int)
    if length(in) < indx
        return nothing
    end
    in[indx-1], in[indx], length(in) < indx ? in[indx+1] : nothing

end

getBeforeAfter(n, 6)


o(x, y, z...) = (x, y, z)

o1 = o(1, 2, 3, 4, 5)

for i in o1
    println(i)
end

function withOptionalValues(x=1, y=2, z=3)
    println("x=$x, y=$y, z=$z")
end

withOptionalValues()


p = map(x -> x^2, 1:10)

p1 = map(1:100) do x
     x^2, (x+1)^2
 end

open("README.md", "r") do io
        println(readuntil(io, "232221"))
end

q = map(first ∘ uppercase, split("sumit is learning Julia language"))

square(x) = x.^2

1:10000 |> sum |> square

 r = [1, 2, 3, 4, 5]

r1 = square.(square.(r))
r2 = @. square(square(r))
isequal(r1, r2)
r1 == r2

try
    throw(AvailabilityException(1, "random"))
catch e
    println("Exception occurred: ", e)
finally
    println("exiting try/catch block")
end


# -------------------------------------------------
using JuliaDB

supplyTemp = Supply("item00001", "each", "node001", "onhand", 100)

t = table([1, 2, 3, 4, 5], [2, 3, 4, 5, 6]; names = [:x, :y])
# t = table((itemId=supplyTemp.itemId, uom=supplyTemp.uom, nodeId=supplyTemp.nodeId, type=supplyTemp.type, quantity=supplyTemp.quantity); pkey=[:itemId, :uom, :nodeId, :type])

save(t, "temp.dat")

filter(r -> r.x == 2, t)

push!(rows(t), (x=20, y=40))

# ------------------------------------------------
# Tasks - async / parallel/ multi-threaded programming

varsize = 1_000_000
function supplyProducer(c::Channel)
    for i in 1:varsize
        s = Supply(string("item_", rand(1:1000)), "each", string("node_", rand(1:100)), "onhand", rand(1:1000))
        put!(c, s)
    end
end

consumer = Channel(supplyProducer)

supplyArray = []

@time for i in 1:varsize
    u = take!(consumer)
    # println(u)
    push!(supplyArray, u)
end

u1 = table([], [], [], [], []; names = (:itemId, :uom, :nodeId, :type, :quantity))

@time for supply in supplyArray
    push!(rows(u1), (itemId = supply.itemId, uom = supply.uom, nodeId =
        supply.nodeId, type=supply.type, quantity=supply.quantity))
    # push!(([1], [2], [3], [4], [5]))
    # push!(rows(u1), (1, 2, 3, 4, 5))
end

save(u1, "temp.dat")
u1 = load("temp.dat")

u2 = filter(r -> r.quantity > 1 && r.itemId == "item_453", u1)

u3 = filter(r -> isequal(r.itemId, "item_453"), u1)
u31 = select(u3, :quantity) |> sum

u4 = select(filter(r -> isequal(r.itemId, "item_453"), u1), :quantity) |> sum

function myItemFilter(tab::IndexedTable)
    filter(r -> isequal(r.itemId, "item_453"), tab)
end

function mySelectQty(tab::IndexedTable)
    select(tab, :quantity)
end

u5 = mySelectQty(myItemFilter(u3)) |> sum

u5 = (mySelectQty ∘ myItemFilter)(u1) |> sum

u6 = ((t -> select(t, :quantity)) ∘ (t -> filter(r -> isequal(r.itemId, "item_453"), t)))(u1) |> sum

function squareAndPrint(arg)
    out = square(arg)
    println("square($arg) = $out")
end

u4 = Task(() -> squareAndPrint(6))
istaskstarted(u4)
istaskdone(u4)
istaskfailed(u4)
a = schedule(u4, 3)

# b = yieldto(u4) TODO it is not returning control back to the main thread. Also, function is not executing. process gets stuck
# yieldto(current_task())

println(b)

# ----------------------------------------
# types, parameteric types, abstract types, etc

u7 = ((applySupplyAdjusters) ∘ (t -> select(t, :quantity)) ∘ (t -> filter(r -> isequal(r.itemId, "item_453"), t)))(u1) |> sum
@time u8 = ((applySupplyAdjusters) ∘ (t -> select(t, :quantity)) ∘ (t -> filter(r -> isequal(r.itemId, "item_453"), t)))(u1) |> sum

# ----------------------------------------
# interfaces

struct Square
    num::Int
end

v1 = Square(10)

Base.iterate(in::Square, i=1) = i > in.num ? nothing : (i*i, i+1)

@benchmark for val in Square(10)
    # println("val=$(val)")
    val * val
end

125 in v1

using Statistics
mean(v1)
sum(v1)

mean(Square(2))
sum(Square(2))

Base.eltype(::Type{Square}) = Int
Base.length(s::Square) = s.num

collect(v1)

function Base.getindex(S::Square, i::Int)
    1 <=i <=S.num || throw(BoundsError(S, i))

    return i * i
end

Square(1000)[15]

Base.firstindex(S::Square) = 1
Base.lastindex(S::Square) = length(S::Square)

firstindex(Square(10000))
lastindex(Square(10010))

Square(10010)[end]

Base.getindex(S::Square, i) = [S[i1] for i1 in i]

Square(100)[(1, 5, 4, 3, 9)]

Square(100)[[1, 5, 4, 3, 9]]
