module Enumerable

  def my_each

    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index

    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < length
      yield self[i], i
      i += 1
    end
    self
  end

  def my_select

    return to_enum(:my_select) unless block_given?

    selection = []

    my_each { |item| selection << item if yield(item) }

    selection

  end


  def my_all?(arg = nil)

    check = true
    if !args
      my_each { |i| check = false unless arg === i }
    else
    my_each { |element| check = false if !yield(element)} 
    end
    check   
  end


  def my_any?( arg = nil)
    check = false

    if arg != nil
      my_each { |i| check = true if arg === i }
    elsif block_given?
    my_each { |element| check = true if yield(element)} 
    else
      my_each{ |element| check = true if element}
    end
    check
  end


  def my_none?(arg = nil)

    check = true

    if arg != nil
      my_each { |i| check = false if arg === i }
    elsif block_given?
    my_each { |element| check = false if yield(element)} 
    else
      my_each{ |element| check = false if element}
    end
    check
  end


  def  my_count( arg = nil)

    count = 0

    if block_given?
      my_each { |element| count += 1 if yield(element) }
    elsif arg
      my_each { |element| count += 1 if element == arg }
    else
      count = size
    end
    count
  end
  
  def my_map
    return to_enum(:my_map) unless block_given?

    mapped = []

    if self.is_a? Range
      self.to_a.my_each { |element| mapped << yield(element)}
    else
    my_each { |element| mapped << yield(element)}
    end
    mapped
  end

  def my_inject(*arg)
    # accumulator = arg[0] if arg[0].is_a? Integer
    if arg[0].is_a? Integer
      accumulator = arg[0]
      sign = arg[1]
      else
        sign = arg[0]
      end
   

    if arg.length == 1 && block_given?

      if self.is_a? Range
      self.to_a.my_each { |item | accumulator = yield(accumulator, item) }  
      else
        my_each { |item | accumulator = yield(accumulator, item)  } 
      end
  
    elsif arg.length == 2
        my_each { |item| accumulator =  accumulator.send(sign, item)} 

    elsif block_given?
      my_each { |item | accumulator = accumulator ? yield(accumulator, item) : item }   
      
    else
      my_each { |item| accumulator = accumulator ? accumulator.send(sign, item) : item}
    end
    accumulator

  end

end


def multiply_els(arr)
  arr.my_inject { |result, value| result * value }
end