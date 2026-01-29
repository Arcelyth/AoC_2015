local file = "../input"
local instructions = {}
local a, b = 1, 0   
local pc = 1

for line in io.lines(file) do
    table.insert(instructions, line)
end

::loop::
while pc <= #instructions do 
    instruction = instructions[pc]
    local inst, next = instruction:match("(%w+) (.*)")
    if inst == "hlf" then
        if next == "a" then
            a = a / 2
        else
            b = b / 2
        end
    elseif inst == "tpl" then
        if next == "a" then
            a = a * 3
        else
            b = b * 3
        end
    elseif inst == "inc" then
        if next == "a" then
            a = a + 1
        else
            b = b + 1
        end
    elseif inst == "jmp" then
        pc = pc + tonumber(next)
        goto loop 

    elseif inst == "jie" then
        local r, offset = next:match("(%w), ([+-]?%d+)") 
        local val = (r == "a") and a or b
        if val % 2 == 0 then 
            pc = pc + tonumber(offset)
            goto loop 
        end
    elseif inst == "jio" then
        local r, offset = next:match("(%w), ([+-]?%d+)")
        local val = (r == "a") and a or b
        if val == 1 then 
            pc = pc + tonumber(offset)
            goto loop 
        end
    else 
        print("Unknown instruction %s", inst)
    end
    pc = pc + 1
end

print(b)
