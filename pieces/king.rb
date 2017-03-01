class King < Piece

  def initialize(board,color)
    super(board, color
    @symbol = '♚'.colorize(color)
  end

  include Steppable

  def move_directions
    [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
  end
end
