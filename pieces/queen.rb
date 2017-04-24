require_relative 'piece'
require_relative 'slideable'

class Queen < Piece

  def initialize(board,color, pos)
    super(board, color, pos)
    @symbol = '♛'.colorize(color)

  end

  include Slideable

  private

  def move_directions
    [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
  end

end
