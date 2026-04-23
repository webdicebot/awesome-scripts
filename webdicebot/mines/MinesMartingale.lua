scriptname='Mines Martingale Recovery by Web DiceBot'
-- description='Classic Martingale strategy for Mines. Recovers losses by doubling bet.'
basebet = 0.00000100
nextbet = basebet

minesTarget = 3 -- Default 3 bombs
minesPicks = {1, 2, 3} -- Picking 3 tiles

function dobet()
    if win then
        nextbet = basebet
        log("Win! Resetting bet to base.")
    else
        nextbet = previousbet * 2
        log("Loss. Doubling bet to: " .. nextbet)
        
        -- Strategy: Change picks randomly after a loss to "scout" new territory
        minesPicks = {}
        local count = 0
        while count < 3 do
            local pick = math.random(0, 24)
            local exists = false
            for _, v in ipairs(minesPicks) do
                if v == pick then exists = true break end
            end
            if not exists then
                table.insert(minesPicks, pick)
                count = count + 1
            end
        end
        log("New tiles picked: " .. table.concat(minesPicks, ", "))
    end
    
    -- Safety: Reset if bet exceeds 5% of balance
    if nextbet > balance * 0.05 then
        nextbet = basebet
        log("Safety triggered: Bet too high, resetting.")
    end
end
