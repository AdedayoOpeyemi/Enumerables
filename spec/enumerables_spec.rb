require './enumerables'



describe Enumerable do

  let(:arr_num) { [1, 2, 3, 4, 5] }


  describe "#my_each" do
    it "returns to enum if no block is provided" do
    expect(arr_num.my_each).to be_a(Enumerator)
    end
  
    it "returns a new array with the result of the operation within the block" do
      expected_result = [4, 5,6,7,8]
      test_result = []
      arr_num.my_each { |n| test_result << n + 3}
      expect(test_result).to eql(expected_result)
    end
  end
end