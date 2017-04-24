module Steppable

  def moves
    move_directions.each do |dx, dy|
      x, y = self.pos
      pos = [x + dx, y + dy]
    end
    directions_to_check.reject{ |move| (!self.board.in_bounds?(move)) || self.board[move].color == self.color }

  end

end
