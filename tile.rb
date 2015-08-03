class Tile
  NEIGHBOR_OFFSETS = [
    [-1, -1],
    [+0, -1],
    [+1, -1],
    [-1, +0],
    [-1, +0],
    [-1, +1],
    [+0, +1],
    [+1, +1]
]

  attr_reader :pos
  attr_writer :bomb, :flagged

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
      revealed: @revealed }
  end

  def bomb?
    bomb
  end

  def flagged?
    flagged
  end

  def revealed?
    revealed
  end

  def reveal
    revealed = true
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
  attr_reader :board, :bomb, :flagged
  attr_accessor :revealed
end
