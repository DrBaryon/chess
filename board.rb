require_relative 'pieces'

class Board

  attr_accessor :grid

  def initialize
    @sentinel = NullPiece.instance
    make_starting_grid
  end

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8) }
    @grid[0] = back_row(:black, 0)
    @grid[1] = pawn_row(:black, 1)
    @grid[2] = Array.new(8) { NullPiece.instance }
    @grid[3] = Array.new(8) { NullPiece.instance }
    @grid[4] = Array.new(8) { NullPiece.instance }
    @grid[5] = Array.new(8) { NullPiece.instance }
    @grid[6] = pawn_row(:black, 6)
    @grid[7] = back_row(:white, 7)
  end

  def back_row(color, row)
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    row_of_pieces = pieces.each_with_index do |piece_class, j|
      piece_class.new(color, self, [row, j])
    end
    return row_of_pieces
  end

  def pawn_row(color, row)
    8.times { |j| Pawn.new(color, self, [row, j]) }
  end

  def in_check?(check_color)
    king_space = nil
    @grid.each do |row|
      row.each do |space|
        if space.is_a?(King) && space.color == check_color
          king_space = space.pos
          break
        end
      end
    end
    opposing_color = nil
    check_color == :white ? opposing_color = :black : opposing_color = :white
    check_all(king_space, opposing_color)
  end

  def check_all(king,color)
    @grid.each do |row|
      row.each do |space|
        if space.color == color
          return true if space.moves.include?(king)
        end
      end
    end
    false
  end

  def checkmate?(color)
    if in_check?(color)
      @grid.each do |row|
        row.each do |space|
          if space.color == color && !space.valid_moves.empty?
            return false
          end
        end
      end
      return true
    end
    false
  end



  def move_piece(start_pos,end_pos)
    piece = self[start_pos]
    if piece.is_a?(NullPiece)
      raise NoPieceError.new ("There is no piece in this starting pos")
    elsif !piece.valid_moves.include?(end_pos)
      raise "You cannot move here")
    end
    self[end_pos] = piece
    piece.pos = end_pos
    self[start_pos] = @sentinel
    nil
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos,value)
    x,y = pos
    grid[x][y] = value
  end

  def in_bounds?(pos)
    x, y = pos
    (x > -1 && x < 8) && (y > -1 && y < 8)
  end


end
