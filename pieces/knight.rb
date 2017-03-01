class Knight < Piece

  def initialize(board, color)
    super(board, color)
    @symbol = '♞'.colorize(color)
  end

  include Steppable

  def move_directions
    [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,-2],[-1,2]]
  end

end
