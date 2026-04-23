scriptname='Limbo Stairway to Heaven by Web DiceBot'
-- description='Progressively increases target multiplier after each win.'
basebet = 0.00000100
nextbet = basebet

targets = {2, 10, 100, 1000, 10000, 100000, 1000000}
targetIndex = 1
chance = 99 / targets[targetIndex]

function dobet()
    if win then
        log("Win at " .. targets[targetIndex] .. "x!")
        targetIndex = targetIndex + 1
        if targetIndex > #targets then
            log("Reached the peak! Resetting.")
            targetIndex = 1
        end
        chance = 99 / targets[targetIndex]
        nextbet = basebet
    else
        -- If we lose at a high target, we don't reset immediately.
        -- We wait a few rolls then try again or downscale.
        if losestreak > 100 then
            targetIndex = math.max(1, targetIndex - 1)
            chance = 99 / targets[targetIndex]
            log("Loss streak high. Lowering target to " .. targets[targetIndex] .. "x")
            nextbet = basebet
        end
    end
end
