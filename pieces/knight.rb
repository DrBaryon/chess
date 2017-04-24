require_relative 'piece'
require_relative 'steppable'

class Knight < Piece

  def initialize(board, color, pos)
    super(board, color, pos)
    @symbol = '♞'.colorize(color)
  end

  include Steppable

  def move_directions
    [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,-2],[-1,2]]
  end

end
