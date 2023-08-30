puts "Enter an equasion"
eq = gets.chomp()
eq.delete! " "
operand = ""
num1 = ""
num2 = ""
for char in eq.chars do
    if char == "+" || char == "-" || char == "*" || char == "/" 
        operand = char
        next  
    end
    if operand == ""
        num1 = num1 + char
    else 
        num2 = num2 + char
    end
end
ans = 0
if operand == "+"
    ans = num1.to_i + num2.to_i
elsif operand == "-"
    ans = num1.to_i - num2.to_i
elsif operand == "*"
    ans = num1.to_i * num2.to_i
elsif operand == "/"
    ans = num1.to_i / num2.to_i
end
puts eq + "=" + ans.to_s