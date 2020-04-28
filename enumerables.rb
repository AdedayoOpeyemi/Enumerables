module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    conv = if is_a? Range
             to_a
           else
             self
           end
    i = 0
    while i < conv.length
      yield conv[i]
      i += 1
    end
    conv
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    conv = if is_a? Range
             to_a
           else
             self
           end
    i = 0
    while i < conv.length
      yield conv[i], i
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
    if args
      my_each { |i| check = false unless arg === i } # rubocop:disable Style/CaseEquality
    else
      my_each { |element| check = false unless yield(element) }
    end
    check
  end

  def my_any?(arg = nil)
    check = false
    if arg
      my_each { |i| check = true if arg === i } # rubocop:disable Style/CaseEquality
    elsif block_given?
      my_each { |element| check = true if yield(element) }
    else
      my_each { |element| check = true if element }
    end
    check
  end

  def my_none?(arg = nil)
    check = true
    if arg
      my_each { |i| check = false if arg === i } # rubocop:disable Style/CaseEquality
    elsif block_given?
      my_each { |element| check = false if yield(element) }
    else
      my_each { |element| check = false if element }
    end
    check
  end

  def my_count(arg = nil)
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

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    mapped = []
    if proc
      my_each { |element| mapped << proc.call(element) }
    else
      my_each { |element| mapped << yield(element) }
    end
    mapped
  end

  def my_inject(*arg)
    if arg[0].is_a? Integer
      accumulator = arg[0]
      sign = arg[1]
    else
      sign = arg[0]
    end
    if arg.length == 1 && block_given?
      my_each { |item| accumulator = yield(accumulator, item) }
    elsif arg.length == 2
      my_each { |item| accumulator = accumulator.send(sign, item) }
    elsif block_given?
      my_each { |item| accumulator = accumulator ? yield(accumulator, item) : item }
    else
      my_each { |item| accumulator = accumulator ? accumulator.send(sign, item) : item }
    end
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject { |result, value| result * value }
end
