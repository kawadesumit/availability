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
