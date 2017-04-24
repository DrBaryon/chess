require 'singleton'

class NullPiece < Piece
  attr_reader :color, :symbol
  def initialize
    @symbol = " "
    @color = :none
  end

  include Singleton

  def moves
    []
  end
end
