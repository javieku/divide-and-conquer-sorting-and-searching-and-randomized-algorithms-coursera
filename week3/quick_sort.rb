require "./pivot_utils"

def quick_sort(array, low, high) 
    return [array[low]] if ( high - low == 1 )
    return [] if ( high - low <= 0 )
    
    (array, pivot_pos) = partition(array, low,  high)
     
    return quick_sort(array, low, pivot_pos) + [array[pivot_pos]] + quick_sort(array, pivot_pos+1, high)
end

def partition(array, low, high) 
    $comparisons += high - low - 1
    
    pivot = select_pivot(array, low, high)
    array[pivot.pos], array[low] = array[low], array[pivot.pos]

    i = low + 1
    for j in low + 1...high
        if (array[j] < pivot.value)
            array[j], array[i] = array[i], array[j]
            i += 1
        end    
    end
    array[low], array[i-1] = array[i-1], array[low]
    return array, i-1
end
 
integers = []
File.open("QuickSort.txt", "r") do |f|
    f.each_line do |line|
        integers.push(line.to_i) 
    end
end

$comparisons = 0

#puts quick_sort([11,2,5,4,10], 0, 5)
quick_sort(integers, 0, integers.length)

# Sol1: 162085
# Sol2: 164123
# Sol3: 138382

puts $comparisons