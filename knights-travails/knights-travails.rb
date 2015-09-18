# Unnecessary for knight exercise but will come in handy for later
class Board
  attr_accessor :grid

  def initialize(grid = Array.new(8, Array.new(8, 0)))
    @grid = grid
  end
end

PathTracker = Struct.new(:position, :path)

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

  # Returns an array of arrays listing all possible paths from the start to finish.
  def self.shortest_path(start, finish)
    if !(valid_position?(start) && valid_position?(finish))
      return nil
    end

    queue = [PathTracker.new(start, [start])]
    visited = [start]

    until queue.empty?
      position = queue.pop
      moves = valid_moves_from(position.position).select { |move| !visited.include?(move) }

      if moves.include?(finish)
        position.path << finish
        return position.path
      end

      moves.each do |move|
        queue.unshift PathTracker.new(move, position.path + [move])
        visited << move
      end
    end
  end

  def self.valid_position?(position = @position)
    return position.all? { |i| i.between?(1, 8) }
  end
end

board = Board.new
board.grid.each { |row| p row }
path = Knight.shortest_path([3, 4], [8, 8])
path.each { |move| p move }
