require './enumerable'

describe Enumerable do
  before :each do
    @ary1 = [1, 2, 3, 4]
    @ary2 = []
    @ary3 = Array.new(5, "abcd")
    @ary4 = Array.new(5)
  end

  describe "#my_select" do
    it "returns an array of the right items" do
      expect(@ary1.my_select { |i| i == 1 }).to eql [1]
      expect(@ary1.my_select { |i| i == 5 }).to eql []
      expect(@ary2.my_select { |i| i == 0 }).to eql []
      expect(@ary3.my_select { |i| i == "abcd" }).to eql ["abcd", "abcd", "abcd", "abcd", "abcd"]
      expect(@ary4.my_select { |i| !i }).to eql [nil, nil, nil, nil, nil]
    end
  end

  describe "#my_all?" do
    it "returns true if all match" do
      expect(@ary1.my_all? { |i| i.is_a? Fixnum }).to be true
      expect(@ary1.my_all? { |i| i == 1 }).to be false
    end
  end
end
