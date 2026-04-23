scriptname='Limbo Flashy Sniper by Web DiceBot'
-- description='Normally bets on low targets, but randomly spikes to massive multipliers.'
basebet = 0.00000100
nextbet = basebet
chance = 99 / 2.0

function dobet()
    if win then
        log("Win!")
        nextbet = basebet
        chance = 99 / 2.0 -- Reset to safe chance
    else
        -- Randomly try to catch a massive spike
        if math.random(1, 100) > 95 then
            local randomTarget = 1000 + math.random(1, 999000)
            chance = 99 / randomTarget -- Spike chance
            nextbet = basebet -- Keep bet low for spikes
            log("!!!! FLASHY SPIKE: Targeting approx " .. math.floor(randomTarget) .. "x (Chance: " .. chance .. ") !!!!")
        else
            chance = 99 / 2.0
            nextbet = previousbet * 1.5 -- Martingale for 2x
        end
    end
    
    if nextbet > balance * 0.05 then
        nextbet = basebet
    end
end
