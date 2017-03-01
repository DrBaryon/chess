require 'singleton'

module Slideable

  def horizontal_dirs
    return [
      [-1, 0],
      [0, -1],
      [0, 1],
      [1, 0]
    ]
  end

  def diagonal_dirs
    return [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ]
  end

  def moves
    starting_pos = self.position
    directions_to_check = move_directions
    possible_moves = []

    move_directions.each do |direction|
      new_position = starting_pos
      while true

        new_position = [new_position[0] + direction[0], new_position[1] + direction[1]]
        if !self.board.in_bounds?(new_position)
          break
        elsif !self.board[new_position].is_a?(NullPiece) && board[new_position].color != self.color
          possible_moves << new_position
          break
        elsif !self.board[new_position].is_a?(NullPiece) && board[new_position].color == self.color
          break
        else
          possible_moves << new_position
        end
      end
    end
    possible_moves
  end
end

module Steppable

  def moves
    pos = self.position
    directions_to_check = move_directions.map{|direction| [pos[0] + direction[0], pos[1] + direction[1]]}
    directions_to_check.reject{ |move| (!self.board.in_bounds?(move)) || self.board[move].color == self.color }

  end

end



class Piece
  attr_reader :board, :color
  attr_accessor :pos

  def initialize(board = nil, color = nil)
    @board = board
    @position = position
    @color = color
  end

  def valid_moves
    moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  private

  def move_into_check?(end_pos)
    test_board = board.dup
    test_board.move_piece!(pos, end_pos)
    test_board.in_check?(color)
  end

end

class NullPiece < Piece
  attr_reader :color, :symbol
  def initialize
    @color = nil
    @symbol = "_"
  end

  include Singleton

  def moves
    []
  end
end

class Rook < Piece
  include Slideable

  def initialize(board, color)
    super(board, color)
    @symbol = "I"
  end

  private

  def move_directions
    [[1,0],[0,1],[-1,0],[0,-1]]
  end

end

class Knight < Piece

  def initialize(board, color)
    super(board, color)
    @symbol = "k"
  end

  include Steppable

  def move_directions
    [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,-2],[-1,2]]
  end

end

class Bishop < Piece

  def initialize(board,color)
    super(board, color)
    @symbol = "B"
  end

  include Slideable

  private

  def move_directions
    [[1,1],[-1,1],[-1,-1],[1,-1]]
  end
end

class King < Piece

  def initialize(board,color)
    super(board, color)
    @symbol = "K"
  end

  include Steppable

  def move_directions
    [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
  end
end

class Queen < Piece

  def initialize(board,color)
    super(board, color)
    @symbol = "Q"

  end

  include Slideable

  private

  def move_directions
    [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
  end

end

class Pawn < Piece

  def initialize(board,color)
    super(board, color)
    @symbol = "i"
  end

  include Steppable

  private

  def move_directions
    possibles = []
    if at_start_row? && color == :cyan
      possibles = [[-1,0],[-2,0]]
    elsif at_start_row? && color == :black
      possibles = [[1,0],[2,0]]
    else
      color == :cyan ? possibles = [1,0] : possibles = [-1,0]
    end
    possibles += side_attacks
  end

  def at_start_row?
    return true if (color == :cyan && position[0] == 6) || (color == :black && position[0] == 1)
    false
  end

  def side_attacks
    if color == :cyan
      attacks = [[-1, -1],[-1, 1]]
    else
      attacks = [[1, 1],[1, -1]]
    end

    attacks.select do |attack|
      !board[self.sum_coords(attack)].is_a?(NullPiece)
    end
  end

  protected

  def sum_coords(coord)
    [coord.first + self.position.first, coord.last + self.position.last]
  end
end
