games = {"dice", "limbo", "keno"}
game = "keno"
wc1 = 98
bb1 = 1e-8

nextbet = bb1
bethigh = true

kenoRisk = "low" -- low, medium, high
kenoNumbers = {34, 35, 36} -- 3 Numbers

function dobet()
    log("kenoRisk " .. tostring(kenoRisk))
    log("lastBet.Result " .. tostring(lastBet.Result))
    log("lastBet.Target " .. tostring(lastBet.Target))

    -- Parse last result numbers
    local lastNumbers = {}
    for resultNumber in string.gmatch(tostring(lastBet.Result), "([^,]+)") do
        table.insert(lastNumbers, resultNumber)
        log("resultNumber " .. resultNumber)
    end

    if win then
        kenoRisk = "low"
        kenoNumbers = {34, 35, 36, 37, 38}  -- 5 Numbers
        if partialprofit >= 0 then
            resetpartialprofit()
            nextbet = bb1
        end
    else
        if losestreak > 6 then
            kenoRisk = "high"
            kenoNumbers = {3, 11, 34, 35, 36, 37, 38} -- 7 Numbers
        elseif losestreak > 3 then
            kenoRisk = "medium"
            kenoNumbers = {34, 35, 36, 37}  --  4 Numbers (Added missing selection for medium risk)
        end
        nextbet = lastBet.Amount * 1.0  -- Changed "previousbet" to "lastBet.Amount"
    end

    -- Cap max bet to 1000x base bet
    nextbet = math.min(nextbet, bb1 * 1000)
end