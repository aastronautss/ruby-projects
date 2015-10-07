require 'spec_helper'

describe Board do
  let(:board) { ConnectFour::Board.new }

  describe "#new" do
    it "creates an empty board" do
      expect(board).to be_an_instance_of(Board)
    end

    it "has a spaces array" do
      expect(board.instance_eval { @spaces }).to be_an_instance_of(Array)
    end

    it "has 42 spaces" do
      expect(board.instance_eval { @spaces }).to eql 42
    end
  end

  # describe "#drop" do
  # end
end
