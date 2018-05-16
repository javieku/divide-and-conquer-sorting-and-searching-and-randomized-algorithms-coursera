def count_inversions(array) 
    (count, sorted_array) = count_inversions_impl(array)
    return count
end

def count_inversions_impl(array) 
    return 0, [] if (array.empty?)
    return 0, [array[0]] if (array.length == 1)
    
    mid = array.length / 2

    (count1,first_segment) = count_inversions_impl(array[0 ... mid])
    (count2,second_segment) = count_inversions_impl(array[mid ... array.length])
    (count3,result) = count_inversions_aux(first_segment, second_segment)

    total_count = count1 + count2 + count3
    return total_count, result
end

def count_inversions_aux(one_array, other_array) 
    result = []
    i = 0
    j = 0
    inversions = 0
    while i < one_array.length || j < other_array.length

        if (i >= one_array.length && j < other_array.length)
            result.push(other_array[j])
            j += 1
            next
        end

        if (j >= other_array.length && i < one_array.length)
            result.push(one_array[i])
            i += 1
            next
        end

        if (one_array[i] <= other_array[j])
            result.push(one_array[i])
            i += 1
        else
            result.push(other_array[j])
            j += 1
            inversions += (one_array.length - i)
        end
    end 
    return inversions, result
end
 
integers = []
File.open("IntegerArray.txt", "r") do |f|
    f.each_line do |line|
        integers.push(line.to_i) 
    end
end

# 2407905288
puts count_inversions(integers)

