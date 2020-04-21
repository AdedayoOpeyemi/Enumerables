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

  def my_all?

    check = true

    my_each { |element| check = false if !yield(element)} 

    check

  end

  def my_any?

    check = false

    my_each { |element| check = true if yield(element)} 

    check
  end

end


