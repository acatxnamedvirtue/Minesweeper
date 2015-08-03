require 'colorize'

class Tile
  COLORS = {
    1 => :red
    2 => :green,
    3 => :yellow,
    4 => :blue,
    5 => :magenta,
    6 => :cyan,
    7 => :light_green,
    8 => :light_red,
  }

  NEIGHBOR_OFFSETS = [
    [-1, -1],
    [+0, -1],
    [+1, -1],
    [-1, +0],
    [+1, +0],
    [-1, +1],
    [+0, +1],
    [+1, +1]
]

  attr_reader :pos
  attr_writer :bomb
  attr_accessor :revealed

  def initialize(board, pos)
    @board = board
    @pos = pos
    @bomb = false
    @flagged = false
    @revealed = false
  end

  def inspect
    { pos: @pos,
      bomb: @bomb,
      flagged: @flagged,
      revealed: @revealed }.inspect
  end

  def to_s
    return "F" if flagged?
    return "*" if !revealed?
    return "B" if bomb?

    case neighbor_bomb_count
    when 0 then "_"
    else
      neighbor_bomb_count.to_s.colorize(COLORS[neighbor_bomb_count])
    end
  end

  def set_bomb
    @bomb = true
  end

  def toggle_flag
    @flagged = !flagged?
  end

  def reveal
    @revealed = true
  end

  def bomb?
    @bomb
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def neighbors
    p_x, p_y = pos
    neighbors = []

    NEIGHBOR_OFFSETS.each do |offset|
      o_x, o_y = offset
      neighbor_pos = [o_x + p_x, o_y + p_y]
      neighbors << board[neighbor_pos] if board.in_range?(neighbor_pos)
    end

    neighbors
  end

  def neighbor_bomb_count
    neighbors.select(&:bomb?).count
  end

  private
  attr_reader :board
end
