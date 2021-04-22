local prefix = ";"


function findCommand(arg)

print(arg)

i, j = string.find(arg, "hello")
print(i, j)

end


while true do



print("||")
local s =  io.read()

findCommand(s)

end