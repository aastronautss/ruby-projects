# Unnecessary for knight exercise but will come in handy for later
class Board
  attr_accessor :grid

  def initialize(grid = Array.new(8, Array.new(8, 0)))
    @grid = grid
  end
end

# Has attributes from
class Knight
  attr_accessor :position

  # Returns a list of all valid moves from the knight's position.
  def self.valid_moves_from(position = @position)
    position.map! { |i| i - 1 } # translate position to array index
    all_moves = all_moves_from(position)
    valid_moves = []
    all_moves.each do |move|
      if move.all? { |coord| coord.between?(0, 8) }
        valid_moves << move.map { |i| i + 1 } # translate array index to position
      end
    end
    valid_moves
  end

  # Returns a list of all possible moves from the knight's current position, even if the coordinates are off the board.
  def self.all_moves_from(position = @position)
    moves = []
    moves << [position[0] + 2, position[1] + 1]
    moves << [position[0] + 2, position[1] - 1]
    moves << [position[0] - 2, position[1] + 1]
    moves << [position[0] - 2, position[1] - 1]
    moves << [position[0] + 1, position[1] + 2]
    moves << [position[0] + 1, position[1] - 2]
    moves << [position[0] - 1, position[1] + 2]
    moves << [position[0] - 1, position[1] - 2]
  end

  # Returns an array of arrays listing all possible paths from the start to finish. The path and list attributes are passed in order to make recursion easier.
  def self.all_paths(start, finish, path = [start], list = [])
    if start == finish # base case
      path << finish
      path = path[0] if path[0] == path[1]
      list << path unless list.include? path
      return list
    end

    moves = valid_moves_from(start)
    moves.each do |move|
      return all_paths(move, finish, path, list)
    end
  end


end

board = Board.new
board.grid.each { |row| p row }
p Knight.all_paths([3, 4], [1, 5])
