scriptname = "KenoFibonacci by Web DiceBot"
basebet = 0.00000100
minbet = 0.00000001
fib_index = 1
max_fib = 20

-- Initialize Fibonacci sequence
fib = {1, 1}
for i=3, max_fib do
    fib[i] = fib[i-1] + fib[i-2]
end

kenoRisk = "low"
kenoNumbers = {1, 10, 20, 30, 40} -- 5 default numbers

nextbet = basebet

function dobet()
    if win then
        -- Win: Move back 2 steps in the sequence
        fib_index = math.max(1, fib_index - 2)
        log("Win! Fibonacci index back to: " .. fib_index)
    else
        -- Lose: Move forward 1 step
        fib_index = math.min(max_fib, fib_index + 1)
        log("Lose! Fibonacci index advanced to: " .. fib_index)
    end
    
    nextbet = basebet * fib[fib_index]
    
    -- Adjust risk based on Fibonacci index
    if fib_index > 10 then
        kenoRisk = "medium"
    elseif fib_index > 15 then
        kenoRisk = "high"
    else
        kenoRisk = "low"
    end
    
    -- Safety limit to protect balance
    if nextbet > balance / 10 then
        nextbet = basebet
        fib_index = 1
    end
end
