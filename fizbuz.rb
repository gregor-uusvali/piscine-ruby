def fizbuz(num)
    (1..num).each do |i|
        if i % 15 == 0
            print "fizbuz"
        elsif i % 5 == 0 
            print "fiz"
        elsif i % 3 == 0
            print "buz"
        else
            print i
        end
        if i != num 
            print "\n"
        end
    end
end

fizbuz(100)