class Board
  def initialize(width = 9, height = 9)
    @grid = Array.new(width) { Array.new(height) }
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, tile)
    x, y = pos
    grid[x][y] = tile
  end
end
