-- ===== INIT =====
scriptname = "4 Mode 4 Wager by Web DiceBot"
startBalance = balance

chance = 50

basebet = balance / 15000
nextbet = basebet

lossStreak = 0
winStreak = 0
totalBets = 0

mode = "LOW"

targetProfit = balance * 0.03
stopLoss = balance * 0.85

-- ===== STRATEGIES =====
strategies = {
    LOW = {chanceMin=60, chanceMax=75, multi=1.10},
    NORMAL = {chanceMin=48, chanceMax=52, multi=1.25},
    RECOVERY = {chanceMin=38, chanceMax=45, multi=1.40},
    SNIPER = {chanceMin=20, chanceMax=30, multi=1.80}
}

-- ===== RANDOM CHANCE =====
function setChance()
    local s = strategies[mode]
    chance = s.chanceMin + math.random() * (s.chanceMax - s.chanceMin)
    bethigh = math.random() > 0.5
end

-- ===== MODE SWITCH =====
function updateMode()
    local profit = balance - startBalance

    if profit > startBalance * 0.015 then
        mode = "LOW"

    elseif lossStreak > 10 then
        mode = "SNIPER"

    elseif lossStreak > 5 then
        mode = "RECOVERY"

    else
        mode = "NORMAL"
    end
end

-- ===== MAIN =====
function dobet()
    totalBets = totalBets + 1

    updateMode()
    setChance()

    local s = strategies[mode]

    -- ===== WIN =====
    if win then
        winStreak = winStreak + 1
        lossStreak = 0

        nextbet = basebet

        -- down risk when more win
        if winStreak > 3 then
            nextbet = basebet * 0.8
        end

    else
        -- ===== LOSE =====
        lossStreak = lossStreak + 1
        winStreak = 0

        nextbet = previousbet * s.multi
    end

    -- sideway when more lose
    if lossStreak > 4 then
        bethigh = not bethigh
    end

    -- reset when too risk
    if lossStreak > 12 then
        nextbet = basebet
        lossStreak = 0
    end

    -- down amount if profit
    if balance > startBalance * 1.02 then
        nextbet = basebet * 0.7
    end

    -- anti pattern (random spike)
    if totalBets % 13 == 0 then
        chance = 30 + math.random() * 40
    end

    -- ===== STOP =====
    if balance >= startBalance + targetProfit then
        stop()
    end

    if balance <= startBalance * 0.85 then
        stop()
    end
end