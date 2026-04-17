nextbet  = 0.00000100 -- sets your first bet --divder 1M
kenoNumbers = {1, 2, 3, 4, 5, 6, 7, 8} -- first bet(round) numbers
kenoRisk     = "low" -- set kenoRisk level(low,medium,high)
game = "keno"
target   = balance * 2 -- target balance

-- Helper: Slice a table
function table.slice(tbl, first, last, step)
    local sliced = {}
    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced+1] = tbl[i]
    end
    return sliced
end

-- Helper: Shuffle a table
local function Shuffle(t)
    local s = {}
    for i = 1, #t do s[i] = t[i] end
    for i = #t, 2, -1 do
        local j = math.random(i)
        s[i], s[j] = s[j], s[i]
    end
    return s
end

-- Returns N random numbers between 1-40
function GetRandomTable(length)
    local table1 = {}
    for i = 1, 40 do
        table.insert(table1, i)
    end
    local table2 = Shuffle(table1)
    return table.slice(table2, 1, length)
end

-- Betting function
function dobet()
    sleep(0.0)

    if balance >= target then
        stop()
    end

    if win then
        kenoNumbers = GetRandomTable(8) --  every win picked 10 new random numbers
        -- Print statements removed per your request
    end
end