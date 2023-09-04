input_string = ARGV[0]
int_array = input_string.gsub('\n', "\n").bytes.map(&:to_i)

def printAscii(res, arr)
    new_line = false
    new_line_idx = 0
    for j in 0..7 do
        if arr[0] == 10 || arr.length == 0
            res = res + "\n"
            new_line = true
            break
        end
        arr.each_with_index do |i, idx|
            index = 1 + (i-32) * 1 + (i-32) * 8
            if index == -197
                new_line = true
                new_line_idx = idx
                break
            end
            File.open("standard.txt", "r") do |file|
                res = res + file.readlines()[index+j].chop
            end
        end
        res = res + "\n"
    end
    if new_line && arr.length != 0
        after_nl = printAscii("", arr[new_line_idx+1..-1])
        res = res + after_nl
    end
    return res
end
puts printAscii(res="", int_array)


