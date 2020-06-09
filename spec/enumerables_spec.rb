require './enumerables'

describe Enumerable do
  let(:arr_num) { [1, 2, 3, 4, 5] }
  let(:arr_duplicate) { [1, 4, 3, 4, 3] }
  let(:arr_mixed) { [1, 2, 3, 'apple', 4, 'dog'] }
  let(:arr_string) { %w[ant bear cat] }
  let(:arr_with_nil) { [nil, true, 99] }
  let(:arr_non_truthy) { [nil, false] }

  describe '#my_each' do
    it 'returns to enum if no block is provided' do
      expect([].my_each).to be_a(Enumerator)
    end

    it 'returns a new array with the result of the operation within the block' do
      expected_result = [4, 5, 6, 7, 8]
      test_result = []
      arr_num.my_each { |n| test_result << n + 3 }
      expect(test_result).to eql(expected_result)
    end
  end

  describe '#my_each_with_index' do
    it 'returns to enum if no block is provided' do
      expect([].my_each_with_index).to be_a(Enumerator)
    end

    it 'returns a new array with the result of the operation within the block' do
      expected_result = [[1, 0], [2, 1], [3, 2], [4, 3], [5, 4]]
      test_result = []
      arr_num.my_each_with_index { |item, index| test_result << [item, index] }
      expect(test_result).to eql(expected_result)
    end
  end

  describe '#my_select' do
    it 'returns to enum if no block is provided' do
      expect(arr_num.my_select).to be_a(Enumerator)
    end

    it 'returns a new array with the result of the operation within the block' do
      expected_result = [2, 4]
      test_result = []
      arr_num.my_select { |item| test_result << item if item.even? }
      expect(test_result).to eql(expected_result)
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements match given arguement' do
      expected_result = true
      test_result = arr_num.my_all?(Integer)
      expect(test_result).to eql(expected_result)
    end

    it 'returns false if not all elements match given arguement' do
      expected_result = false
      test_result = arr_num.my_all?(String)
      expect(test_result).to eql(expected_result)
    end

    it 'returns false if not all elements match given arguement' do
      expected_result = false
      test_result = arr_mixed.my_all?(Integer)
      expect(test_result).to eql(expected_result)
    end

    it 'returns false if not all elements match given arguement' do
      expected_result = true
      test_result = arr_string.my_all? { |word| word.length >= 3 }
      expect(test_result).to eql(expected_result)
    end

    it 'returns false if any element returns nil' do
      expected_result = false
      test_result = arr_with_nil.my_all?
      expect(test_result).to eql(expected_result)
    end
  end

  describe '#my_any?' do
    it 'returns true if any element matches given arguement' do
      expected_result = true
      test_result = arr_num.my_any?(Integer)
      expect(test_result).to eql(expected_result)
    end

    it 'returns false if none of the elements matches the given arguement' do
      expected_result = false
      test_result = arr_num.my_all?(String)
      expect(test_result).to eql(expected_result)
    end

    it 'returns true if any of the elements match given arguement' do
      expected_result = true
      test_result = arr_mixed.my_any?(Integer)
      expect(test_result).to eql(expected_result)
    end

    it 'returns true if any elements match given conditions' do
      expected_result = true
      test_result = arr_string.my_all? { |word| word.length >= 3 }
      expect(test_result).to eql(expected_result)
    end

    it 'returns false if none of the element is a truthy value' do
      expected_result = false
      test_result = arr_non_truthy.my_all?
      expect(test_result).to eql(expected_result)
    end
  end

  describe '#my_none?' do
    it 'returns true if none of the elements match given argument' do
      expected_result = false
      test_result = arr_num.my_none?(Integer)
      expect(test_result).to eql(expected_result)
    end

    it 'returns true if none of the elements match given argument' do
      expected_result = true
      test_result = arr_num.my_none?(String)
      expect(test_result).to eql(expected_result)
    end

    it 'returns true if none of the elements match given arguement' do
      expected_result = false
      test_result = arr_mixed.my_none?(Integer)
      expect(test_result).to eql(expected_result)
    end

    it 'returns true if none elements match given conditions' do
      expected_result = false
      test_result = arr_string.my_none? { |word| word.length >= 3 }
      expect(test_result).to eql(expected_result)
    end

    it 'returns false if none of the element is a truthy value' do
      expected_result = true
      test_result = arr_non_truthy.my_none?
      expect(test_result).to eql(expected_result)
    end
  end

  describe 'my_count' do
    it 'returns number of elements in a given array or range' do
      expected_result = 5
      test_result = arr_num.my_count
      expect(test_result).to eql(expected_result)
    end

    it 'returns number of elements in a given array or range with specified conditions' do
      expected_result = 3
      test_result = arr_string.my_count{|word| word.length >= 3}
      expect(test_result).to eql(expected_result)
    end

    it 'returns number of elements in a given array or range with specified conditions' do
      expected_result = 2
      test_result = arr_duplicate.my_count(4)
      expect(test_result).to eql(expected_result)
    end
  end

  describe 'my_map' do
    it 'returns Enumerator if no block is given' do
      expect([].my_map).to be_a(Enumerator)
    end

    it 'returns an array if a block is given' do
      test_result = arr_string.my_map{|word| word if (word.length >= 3)}
      expect(test_result).to be_an_instance_of(Array)
    end

    it 'returns an array with elements that meet specified condition' do
      expected_result = %w[ant bear cat]
      test_result = arr_string.my_map{|word| word if (word.length >= 3)}
      expect(test_result).to eql(expected_result)
    end
  end

end
