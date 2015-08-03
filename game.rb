require_relative 'board'
require_relative 'tile'

class Game
  def initialize
    @board = Board.new
  end

  def run

  end

  def get_move
    pos = get_pos
    action = get_action
  end

  def get_pos
    pos = nil

    until valid_pos?(pos)
      puts "Please enter a position x, y"
      pos = gets.chomp.split(",")
    end

    pos
  end

  def get_action
    action = nil

    until valid_action?(action)
      puts "Please enter an action, e.g. toggle (F)lag, (R)eveal"
      action = gets.chomp[0].downcase.to_sym
    end

    action
  end

  private

  def valid_pos?(pos)
    board.in_range?(pos)
  end

  def valid_action?(action)
    [:f, :r].any? { |sym| sym == action }
  end
end
