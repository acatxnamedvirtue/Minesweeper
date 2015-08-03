class Board
  def initialize(width = 9, height = 9)
    @grid = Array.new(width) { Array.new(height) }
  end
end
