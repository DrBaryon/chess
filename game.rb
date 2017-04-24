require_relative 'board'
require_relative 'pieces'
require_relative 'cursor'
require_relative 'display'

class Game

  attr_reader :board, :display

  def play
    puts board
    until board.checkmate?(:cyan) || board.checkmate?(:black)
      @player1.play_turn


    end
  end

  def initialize
    @board = Board.new
    @display = Display.new(board)
    @player1 = HumanPlayer.new(@display)
    @player2 = HumanPlayer.new(@display)

  end


end

class HumanPlayer

  attr_reader :display

  def initialize(display)
    @display = display
  end


  def play_turn
    display.render
    puts "Pick a piece"
    piece_pos, move_pos = nil, nil
    until piece_pos != nil
      piece_pos = display.cursor.get_input
      display.render
    end
    puts "Move where?"
    until move_pos != nil
      move_pos = display.cursor.get_input
      display.render
    end
    display.board.move_piece(piece_pos, move_pos)
    display.render
  end

end
