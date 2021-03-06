require_relative 'piece'
require_relative 'steppable'

class Pawn < Piece

  def initialize(board,color, pos)
    super(board, color, pos)
    @symbol = '♟'.colorize(color)
  end

  include Steppable

  private

  def moves
    possibles = []
    if at_start_row? && color == :white
      possibles = [[-1,0],[-2,0]]
    elsif at_start_row? && color == :black
      possibles = [[1,0],[2,0]]
    else
      color == :white ? possibles = [1,0] : possibles = [-1,0]
    end
    possibles += side_attacks
  end

  def at_start_row?
    return true if (color == :white && position[0] == 6)
    return true if (color == :black && position[0] == 1)
    false
  end

  def side_attacks
    if color == :white
      attacks = [[-1, -1],[-1, 1]]
    else
      attacks = [[1, 1],[1, -1]]
    end
    attacks.select do |attack|
      self.sum_coords(attack).is_a?(NullPiece)
    end
  end

  protected

  def sum_coords(coord)
    return [[coord.first + self.pos.first], [coord.last + self.pos.last]]
  end
end
