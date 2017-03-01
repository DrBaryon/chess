require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display

  attr_reader :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],@board)
  end

  def render
    @board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, piece_idx|
        #debugger
        if [row_idx, piece_idx] == cursor.cursor_pos
          print "#{piece.symbol}".colorize(:red)
        else
          print "#{piece.symbol}".colorize(piece.color)
        end
      end
      print "\n"
    end
  end

  def refresh_display
    while true
      render
      @cursor.get_input
    end
  end
end
