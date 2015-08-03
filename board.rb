require 'byebug'
require_relative 'tile'

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

  def populate
    rows.each_with_index do |row, row_idx|
      row.each_with_index do |_, col_idx|
        pos = [row_idx, col_idx]
        self[pos] = Tile.new(self, pos)
      end
    end
  end

  def rows
    grid
  end

  private
  attr_reader :grid
end
