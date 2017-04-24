require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
  include Slideable

  def initialize(board, color, pos)
    super(board, color, pos)
    @symbol = '♜'.colorize(color)
  end

  private

  def move_directions
    [[1,0],[0,1],[-1,0],[0,-1]]
  end

end
