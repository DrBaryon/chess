class Pawn < Piece

  def initialize(board,color)
    super(board, color)
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
      !board[self.sum_coords(attack)].is_a?(NullPiece)
    end
  end

  protected

  def sum_coords(coord)
    [coord.first + self.position.first, coord.last + self.position.last]
  end
end
