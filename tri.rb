require 'colorize'
def printTriangle(num)
    for i in 1..num do
        for k in 1..num-i do
            print " "
        end
        for j in 1..i do
            if i % 2 == 0
                print "#".red
            else
                print "#".green
            end
        end
        for l in 1..i-1 do
            if i % 2 == 0
                print "#".red
            else
                print "#".green
            end
        end
        if i != num
            print "\n"
        end
    end
end
printTriangle(13)
