require_relative 'piece'
require_relative 'steppable'

class King < Piece

  def initialize(board,color, pos)
    super(board, color, pos)
    @symbol = '♚'.colorize(color)
  end

  include Steppable

  def move_directions
    [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
  end
end
