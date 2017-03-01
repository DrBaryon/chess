class Rook < Piece
  include Slideable

  def initialize(board, color)
    super(board, color)
    @symbol = '♜'.colorize(color)
  end

  private

  def move_directions
    [[1,0],[0,1],[-1,0],[0,-1]]
  end

end
