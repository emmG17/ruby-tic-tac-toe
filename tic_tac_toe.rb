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
    occupied = @slots[place]
    @slots[place] = mark unless occupied
  end

  def slot_occupied?(place)
    @slots[place]
  end

  def full?
    @slots.values.none?(nil)
  end

  def find_three
    find_three_in_row || find_three_in_col || find_three_in_diag
  end

  def find_three_in_row
    (@slots[1] == @slots[2] && @slots[1] == @slots[3]) ||
      (@slots[4] == @slots[5] && @slots[4] == @slots[6]) ||
      (@slots[7] == @slots[8] && @slots[7] == @slots[9])
  end

  def find_three_in_col
    (@slots[1] == @slots[4] && @slots[1] == @slots[7]) ||
      (@slots[2] == @slots[5] && @slots[2] == @slots[8]) ||
      (@slots[3] == @slots[6] && @slots[3] == @slots[9])
  end

  def find_three_in_diag
    (@slots[1] == @slots[5] && @slots[1] == @slots[9]) ||
      (@slots[3] == @slots[5] && @slots[3] == @slots[7])
  end
end

class Player
  attr_reader :mark, :name

  def initialize(mark, name)
    @mark = mark
    @name = name
  end
end

class Game
  def initialize
    @current_turn = 0
    @board = Board.new
    @players = [Player.new('X', 'Player 1'), Player.new('O', 'Player 2')]
    @current_player = @players[0]
    @next_player = @players[1]
  end

  private

  def turn
    @current_turn += 1
    selected_slot = player_input
    @board.write_slot(selected_slot, @current_player.mark)
    @board.print_board
    swap_players
  end

  def player_input
    valid_slot = false
    input = 0
    until valid_slot
      puts "#{@current_player.name}, select a free slot"
      input = gets.to_i
      valid_slot = !@board.slot_occupied?(input)
    end
    input
  end

  def swap_players
    @current_player, @next_player = @next_player, @current_player
  end

  def winner?
    @board.find_three if @current_turn > 4
  end

  public

  def play
    @board.print_board
    turn until @board.full? || winner?
    if winner?
      puts "#{@next_player.name} won the game"
    else
      puts 'It\'s a draw'
    end
  end
end
