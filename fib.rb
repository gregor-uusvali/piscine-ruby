def fib(num)
    if num <= 1
        return num
    end
    return fib(num-1) + fib(num-2)
end
num = 9

puts num.to_s + "th Fibonacci Number: " + fib(num).to_s