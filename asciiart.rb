int_array = ARGV[0].bytes.map(&:to_i)
int_array.map! { |num| num - 32 }

puts int_array.to_s
res = ""
for j in 0..7 do
    for i in int_array
        index = 1 + i * 1 + i * 8
        File.open("standard.txt", "r") do |file|
            res = res + file.readlines()[index+j].chop
        end
    end
    res = res + "\n"
end
print res
