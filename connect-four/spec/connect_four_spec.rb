require 'spec_helper'

describe ConnectFour::Board do
  let(:board) { ConnectFour::Board.new }

  describe "#new" do
    it "creates an empty board" do
      expect(board).to be_an_instance_of(ConnectFour::Board)
    end

    it "has a spaces array" do
      expect(board.instance_eval { @spaces }).to be_an_instance_of(Array)
    end

    it "has 42 spaces" do
      expect(board.instance_eval { @spaces }.length).to eql 42
    end
  end

  describe "#get_column" do
    context "when column not on board" do
      it "raises and error" do
        expect { board.get_column(-1) }.to raise_error("Invalid Input!")
        expect { board.get_column(7) }.to raise_error("Invalid Input!")
      end
    end

    context "when column on board" do
      it "returns the requested column" do
        board.spaces[0], board.spaces[7] = :red, :black
        expect(board.get_column(0)).to eql [:red, :black, nil, nil, nil, nil]
      end
    end
  end

  describe "#open_column?" do
    context "when column is open" do
      it "returns true" do
        expect(board.open_column?(0)).to be true
      end
    end

    context "when column is not open" do
      it "returns false" do
        board.spaces[0], board.spaces[7], board.spaces[14], board.spaces[21], board.spaces[28], board.spaces[35] = :red, :red, :black, :red, :black, :red
        expect(board.open_column?(0)).to be false
      end
    end
  end

  describe "#drop" do
    context "when incorrect coordinates" do
      it "raises an error when input is off the board" do
        expect { board.drop(:red, 0) }.to raise_error("Invalid Input!")
        expect { board.drop(:red, 8) }.to raise_error("Invalid Input!")
      end

      it "raises an error when column is full" do
        board.spaces.map!.with_index{ |s, i| :red if i % 7 == 4 }
        expect { board.drop(:red, 5) }.to raise_error("Column Full!")
      end
    end

    context "when correct coordinates" do
      it "adds a piece to the top of the selected column" do
        board.spaces[1], board.spaces[8] = :red, :black
        board.drop(:red, 2)
        expect(board.get_column(1)).to eql([:red, :black, :red, nil, nil, nil])
      end
    end
  end
end
