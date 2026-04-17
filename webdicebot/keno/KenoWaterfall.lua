
scriptname = "Keno Waterfall by Web DiceBot"
game = "keno"
basebet = 0.00000100
minbet  = 0.00000001
nextbet = basebet
kenoRisk = "medium"

-- Pool limited to 1-40
local pool = {3, 7, 11, 15, 19, 23, 27, 31, 35, 39}

function updateNumbers(count)
    kenoNumbers = {}
    for i=1, count do
        table.insert(kenoNumbers, pool[i])
    end
    log("Waterfall effect: Betting on " .. count .. " numbers")
end

current_count = 10
updateNumbers(current_count)

function dobet()
    if win then
        log("Win! Resetting waterfall to 10 numbers.")
        current_count = 10
        nextbet = basebet
        updateNumbers(current_count)
    else
        nextbet = lastBet.Amount * 1.1
        
        if current_count > 2 then
            current_count = current_count - 1
            updateNumbers(current_count)
        end
    end
    
    if not nextbet or nextbet < minbet then nextbet = minbet end
    if nextbet > balance * 0.03 then
        current_count = 10
        updateNumbers(current_count)
        nextbet = basebet 
    end
end
