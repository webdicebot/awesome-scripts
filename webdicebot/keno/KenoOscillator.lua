
scriptname = "Keno Oscillator by Web DiceBot"
game = "keno"
basebet = 0.00000100
minbet  = 0.00000001
nextbet = basebet
current_mode = "safe"

function setKeno(mode)
    if mode == "safe" then
        kenoRisk = "low"
        kenoNumbers = {2, 4, 6, 8, 10, 22, 24, 26, 28, 30} -- Even numbers under 40
        log("Switching to SAFE mode (Low risk, 10 numbers)")
    else
        kenoRisk = "high"
        kenoNumbers = {7, 37} -- 2 numbers under 40
        log("Switching to AGGRESSIVE mode (High risk, 2 numbers)")
    end
end

setKeno(current_mode)

function dobet()
    if win then
        if current_mode == "aggressive" then
            log("BIG HIT in aggressive mode! Returning to safe mode.")
            current_mode = "safe"
            setKeno(current_mode)
        end
        nextbet = basebet
    else
        nextbet = lastBet.Amount
        
        if current_mode == "safe" and losestreak > 4 then
            log("Loss streak in safe mode. Oscillating to AGGRESSIVE!")
            current_mode = "aggressive"
            setKeno(current_mode)
            nextbet = basebet
        elseif current_mode == "aggressive" and losestreak > 10 then
            log("No luck hunting. Back to safe mode to recover.")
            current_mode = "safe"
            setKeno(current_mode)
            nextbet = basebet * 2
        end
    end

    if not nextbet or nextbet < minbet then nextbet = minbet end
    if nextbet > balance * 0.05 then nextbet = basebet end
end
