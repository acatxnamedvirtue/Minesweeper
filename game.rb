require_relative 'board'
require_relative 'tile'

class Game
  def initialize
    @board = Board.new
  end

  def run
    until board.over?

    end
  end

  def make_move
    pos, action = nil, nil

    until valid_move?(pos, action)
      pos = get_pos
      action = get_action
    end

    case action
    when :f then board.flag_tile(pos)
    when :r then board.reveal_tile(pos)
    end
  end

  private
  attr_reader :board

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

  def valid_pos?(pos)
    board.in_range?(pos)
  end

  def valid_action?(action)
    [:f, :r].any? { |sym| sym == action }
  end
end
