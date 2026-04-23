scriptname='Dice Smart Oscillator by Web DiceBot'
-- description='Switches between high-probability (safe) and low-probability (profit) modes.'
basebet = 0.00000100
nextbet = basebet
chance = 50
bethigh = true

function dobet()
    if win then
        if chance < 80 then
            -- If we win, we go safer to lock in profit
            chance = chance + 5
            log("Win! Going safer: " .. chance .. "% chance")
        else
            -- If already very safe, reset to aggressive to hunt profit
            chance = 30
            log("Max safety reached. Going aggressive: " .. chance .. "% chance")
        end
        nextbet = basebet
    else
        -- On loss, we increase bet slightly and go to a medium chance
        chance = 49.5
        nextbet = previousbet * 2
        
        if losestreak > 5 then
            -- High loss streak, go very safe to recover
            chance = 90
            nextbet = previousbet * 1.1
            log("Loss streak high. Recovery mode: 90% chance")
        end
    end
    
    -- Safety
    if nextbet > balance * 0.1 then
        nextbet = basebet
        chance = 50
    end
end
