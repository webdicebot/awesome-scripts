scriptname='Mines Progressive Hunter by Web DiceBot'
-- description='Increases risk by adding more tiles to pick on each win.'
basebet = 0.00000100
nextbet = basebet

minesTarget = 3 -- Start with 3 bombs
initialPicks = 1
currentPicks = initialPicks

-- Helper to generate random picks
function generatePicks(count)
    local picks = {}
    local seen = {}
    while #picks < count do
        local pick = math.random(0, 24)
        if not seen[pick] then
            table.insert(picks, pick)
            seen[pick] = true
        end
    end
    return picks
end

minesPicks = generatePicks(currentPicks)

function dobet()
    if win then
        nextbet = previousbet * 1.1 -- Slow profit increase
        currentPicks = currentPicks + 1
        
        -- Cap picks to avoid impossible games (25 tiles - bombs)
        if currentPicks > (25 - minesTarget) then
            currentPicks = initialPicks
            nextbet = basebet
            log("Max picks reached! Resetting strategy.")
        end
        
        log("Win! Increasing picks to: " .. currentPicks)
    else
        nextbet = basebet
        currentPicks = initialPicks
        log("Loss. Resetting picks and bet.")
    end
    
    minesPicks = generatePicks(currentPicks)
    
    -- Stop if balance is too low
    if balance < basebet * 10 then
        stop()
        log("Balance too low. Stopping.")
    end
end
