def merge_sort(array) 
    return [] if (array.empty?)
    return [array[0]] if (array.length == 1)
    
    mid = array.length / 2

    first_segment = merge_sort(array[0 ... mid])
    second_segment = merge_sort(array[mid ... array.length])
    result = merge(first_segment, second_segment)

    return result
end

def merge(one_array, other_array) 
    result = []
    i = 0
    j = 0
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

        if (one_array[i] < other_array[j])
            result.push(one_array[i])
            i += 1
        else
            result.push(other_array[j])
            j += 1
        end
    end 
    return result
end
 

puts merge_sort([11,2,5,4,10])
