  def select_pivot(array, low, high)
        select_median(array, low, high)
    end 
    
    class Pivot
        include Comparable
        attr :pos
        attr :value
        def <=>(anOther)
          @value <=> anOther.value
        end
        def initialize(pos, value)
          @pos = pos
          @value = value
        end
    end
    
    def select_first(array, low, high)
        Pivot.new(low, array[low])
    end 
    
    def select_last(array, low, high)
        Pivot.new( high-1, array[high - 1])
    end 
    
    def select_middle(array, low, high)
        size = high - low
        if (size % 2 == 0)
            Pivot.new( size/2 - 1, array[(size / 2) - 1])
        else 
            Pivot.new( size/2, array[size / 2])
        end
    end
    
    def median_of a
        return nil if a.empty?
        sorted = a.sort
        len = sorted.length
        sorted[len / 2]
    end
    
    def select_median(array, low, high)
        first_pivot = select_first(array, low, high)
        last_pivot = select_last(array, low, high)
        middle_pivot = select_middle(array, low, high)
        median_of [first_pivot, last_pivot, middle_pivot]
    end 
