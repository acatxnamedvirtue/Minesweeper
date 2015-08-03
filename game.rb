require_relative 'board'
require_relative 'tile'

class Game
  DIFFICULTY_LEVELS = {
    e: { height: 8,
         width: 8,
         num_bombs: 10 },
    m: { height: 16,
         width: 16,
         num_bombs: 40 },
    h: { height: 24,
         width: 24,
         num_bombs: 99 }
  }

  def self.from_difficulty(difficulty)
    d = DIFFICULTY_LEVELS[difficulty]
    height, width, num_bombs = d[:height], d[:width], d[:num_bombs]

    Game.new(height, width, num_bombs)
  end

  def self.load_game
    saved_game = File.read("saved_game.yml")

    YAML.load(saved_game)
  end

  def initialize(height, width, num_bombs)
    @board = Board.new(height, width, num_bombs)

    board.populate
    board.add_bombs
  end

  def run
    until board.over?
      board.render
      make_move
    end

    end_game
  end

  private
  attr_reader :board

  def get_pos
    pos = nil

    until valid_pos?(pos)
      puts "Please enter a position x, y"
      pos = gets.chomp.split(",").map(&:to_i)
    end

    pos
  end

  def end_game
    board.reveal_all
    board.render

    if board.won?
      puts "You won!"
    else
      puts "You lost!"
    end
  end

  def get_action
    action = nil

    until valid_action?(action)
      puts "Please enter an action, e.g. toggle (F)lag, (R)eveal, or (S)ave"
      action = gets.chomp[0].downcase.to_sym
    end

    action
  end

  def valid_pos?(pos)
    return false unless pos

    board.in_range?(pos)
  end

  def valid_action?(action)
    [:f, :r, :s].include?(action)
  end

  def make_move
    pos, action = nil, nil

    #until valid_move?(pos, action)
      pos = get_pos
      action = get_action
    #end

    case action
    when :f then board.flag_tile(pos)
    when :r then board.reveal_tile(pos)
    when :s then save_game
    end
  end

  def save_game
    File.open("saved_game.yml", "w") do |file|
      file.puts self.to_yaml
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Start a (N)ew game or (L)oad game?"
  option = gets.chomp[0].downcase.to_sym
  if option == :l
    game = Game.load_game
  else
    puts "Please choose a difficulty: (E)asy, (M)edium, (H)ard, (C)ustom."
    difficulty = gets.chomp[0].downcase.to_sym

    if [:e, :m, :h].include?(difficulty)
      game = Game.from_difficulty(difficulty)
    elsif difficulty == :c
      puts "Please enter a height: "
      print ">"
      height = gets.chomp.to_i

      puts "Please enter a width: "
      print ">"
      width = gets.chomp.to_i

      puts "Please enter the number of bombs: "
      print ">"
      num_bombs = gets.chomp.to_i

      game = Game.new(height, width, num_bombs)
    end
  end

  game.run
end
