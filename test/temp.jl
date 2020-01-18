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

h = join([1, 2, 3, 4, 5], " \n", "\n$(repeat("a", 10))")

codeunit(a, 1)

length(a)

nextind(a, 1, 4)
