scriptname='Mines Sniper (High Risk) by Web DiceBot'
-- description='Uses 20 bombs and picks only 1 tile for massive multipliers.'
basebet = 0.00000010
nextbet = basebet

minesTarget = 20 -- 20 Bombs!
minesPicks = {12} -- Always pick the center tile (12 is center for 0-24)

function dobet()
    if win then
        log("JACKPOT! Win with 20 bombs!")
        nextbet = basebet
        -- Change tile after a win
        minesPicks = {math.random(0, 24)}
    else
        -- Since it's 20 bombs, win chance is low (5/25 = 20%).
        -- Multiplier is very high, so we can afford a long lose streak.
        -- We increase bet slightly or stay flat.
        
        if losestreak > 20 then
            nextbet = previousbet * 1.05 -- Very slow increase
        else
            nextbet = basebet
        end
        
        -- Occasionally randomize tile if on a long loss streak
        if losestreak % 10 == 0 then
            minesPicks = {math.random(0, 24)}
            log("Loss streak " .. losestreak .. ". Switching sniper target.")
        end
    end
    
    -- Emergency stop
    if balance < basebet * 100 then
        log("Low balance safety. Stopping.")
        stop()
    end
end
