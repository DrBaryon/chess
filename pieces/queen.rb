class Queen < Piece

  def initialize(board,color)
    super(board, color)
    @symbol = '♛'.colorize(color)

  end

  include Slideable

  private

  def move_directions
    [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
  end

end
