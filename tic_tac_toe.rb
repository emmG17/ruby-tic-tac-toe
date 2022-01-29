class Board
  def initialize
    @slots = {}
    create_slots
  end

  private

  def create_slots
    (1..9).each do |num|
      @slots[num] = nil
    end
  end

  public

  def print_board
    current_slot_value = (1..9).map { |num| @slots[num] || num }
    puts " #{current_slot_value[0]} | #{current_slot_value[1]} | #{current_slot_value[2]}
___ ___ ___
 #{current_slot_value[3]} | #{current_slot_value[4]} | #{current_slot_value[5]}
___ ___ ___
 #{current_slot_value[6]} | #{current_slot_value[7]} | #{current_slot_value[8]}"
  end

  def write_slot(place, mark)
    @slots[place] = mark unless @slots[place]
  end

  def full?
    @slots.values.length == 9
  end
end

class Player
  attr_reader :mark, :name

  def initialize(name, mark)
    @mark = mark
    @name = name
  end
end

class Game
  def initialize
    @board = Board.new
    @players = [Player.new('X', 'Player 1'), Player.new('Y', 'Player 2')]
    @current_player = @players[0]
    @next_player = @players[1]
  end

  private

  def turn
    @board.print_board
    selected_slot = get_player_input
    @board.write_slot(selected_slot, @player.mark)
    swap_players
  end

  def player_input
    puts 'Select a slot'
    gets(1).to_i
  end

  def swap_players
    temp = @current_player
    @current_player = @next_player
    @next_player = temp
  end

  def play
    turn until @board.full?
  end
end
