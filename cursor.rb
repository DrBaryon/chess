require "io/console"
require 'byebug'

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
  end

  def toggle_selected
    @selected = !@selected
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false
    STDIN.raw!
    input = STDIN.getc
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
    STDIN.cooked!
    STDIN.echo = true
    return input
  end

  def handle_key(key)
    case key
    when :ctrl_c
      exit 0
    when :return, :space
      toggle_selected
      cursor_pos
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      nil
    else
      puts key
    end
  end

  def update_pos(diff)
    delta_x, delta_y = diff
    x, y = @cursor_pos
    new_pos = [x + delta_x, y + delta_y]
    @cursor_pos = new_pos if board.in_bounds?(new_pos)
    #nil
  end
end
