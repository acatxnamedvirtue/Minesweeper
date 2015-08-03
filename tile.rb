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

  attr_writer :bomb, :flagged

  def initialize(board, pos)
    @board = board
    @pos = pos
    @bomb = false
    @flagged = false
    @revealed = false
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

  private
  attr_reader :board, :pos, :bomb, :flagged
  attr_accessor :revealed
end
