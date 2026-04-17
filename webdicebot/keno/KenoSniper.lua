
scriptname = "Keno Sniper by Web DiceBot"
game = "keno"
basebet = 0.00000100
minbet  = 0.00000001
nextbet = basebet
kenoRisk = "medium"

-- Clusters for 40-number board (4 rows of 10)
local clusters = {
    {1,2,3,4,5,6,7,8,9,10},    -- Row 1
    {31,32,33,34,35,36,37,38,39,40}, -- Row 4
    {1,11,21,31},              -- Column 1
    {10,20,30,40},             -- Column 10
    {15,16,25,26}              -- Center Square
}

cluster_index = 1
kenoNumbers = clusters[cluster_index]

function dobet()
    if win then
        log("Target hit! Staying on current cluster.")
        nextbet = basebet
    else
        nextbet = lastBet.Amount
        
        if losestreak % 5 == 0 then
            cluster_index = cluster_index % #clusters + 1
            kenoNumbers = clusters[cluster_index]
            log("No hit. Moving sniper target to cluster: " .. cluster_index)
        end
        
        if losestreak > 3 then
            nextbet = nextbet * 1.2
        end
    end
    
    if not nextbet or nextbet < minbet then nextbet = minbet end
    if nextbet > balance * 0.02 then nextbet = basebet end
end
