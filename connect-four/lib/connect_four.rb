module ConnectFour
  class Board
    attr_accessor :spaces

    def initialize
      @height = 6
      @width = 7
      @number_of_spaces = @height * @width

      @spaces = Array.new(@number_of_spaces)
    end

    def drop(color, column_num)
      column_num -= 1

      if (0...@width).include?(column_num)
        if open_column?(column_num)
          column = get_column(column_num)
          first_open = column.index(nil)
          @spaces[@width * first_open + column_num] = color
        else
          raise "Column Full!"
        end
      else
        raise "Invalid Input!"
      end
    end

    def get_column(column_num)
      if (0...@width).include?(column_num)
        return @spaces.select.with_index { |s, i| i % @width == column_num }
      else
        raise "Invalid Input!"
      end
    end

    def open_column?(column_num)
      column = get_column(column_num)
      column.any? { |i| !i }
    end
  end
end
