module Slideable

  def horizontal_dirs
    return [
      [-1, 0],
      [0, -1],
      [0, 1],
      [1, 0]
    ]
  end

  def diagonal_dirs
    return [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ]
  end

  def moves
    moves = []
    move_directions.each do |dx, dy|
      x,y = self.pos
      while true
        pos = [x + dx, y + dy]
        if !self.board.in_bounds?(pos)
          break
        elsif !self.board[pos].empty? && board[pos].color != self.color
          moves << pos
          break
        elsif !self.board[new_position].is_a?(NullPiece) && board[new_position].color == self.color
          break
        else
          possible_moves << new_position
        end
      end
    end
    possible_moves
  end
end
