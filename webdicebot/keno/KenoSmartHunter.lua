
scriptname = "Keno Smart Hunter by Web DiceBot"
basebet = 0.00000100
nextbet = basebet
kenoRisk = "classic" -- classic, low, medium, high

-- Initial numbers under 40
kenoNumbers = {5, 15, 25, 35, 10, 20, 30, 40}

function dobet()
    local hotNumbers = {}
    local count = 0
    
    for num in string.gmatch(tostring(lastBet.Result), "([^,]+)") do
        local n = tonumber(num)
        if n and n <= 40 then -- Only pick numbers within board range
            table.insert(hotNumbers, n)
            count = count + 1
        end
        if count >= 5 then break end
    end
    
    if #hotNumbers >= 3 then
        kenoNumbers = hotNumbers
        log("Updated numbers from last result: " .. table.concat(kenoNumbers, ","))
    end

    if win then
        nextbet = basebet
        kenoRisk = "low"
    else
        nextbet = lastBet.Amount * 1.5
        
        if losestreak > 2 then
            kenoRisk = "medium"
        end
        
        if losestreak > 5 then
            kenoRisk = "high"
            kenoNumbers = {}
            for i=1,10 do
                table.insert(kenoNumbers, math.random(1, 40)) -- Range 1-40
            end
        end
    end
    
    if not nextbet or nextbet < 0.00000001 then nextbet = basebet end
    if nextbet > balance * 0.05 then nextbet = basebet end
end
