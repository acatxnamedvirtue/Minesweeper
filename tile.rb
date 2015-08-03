class Tile
  def initialize(board, pos)
    @board = board
    @pos = pos
    @bomb = false
    @flagged = false
    @revealed = false
  end
end
