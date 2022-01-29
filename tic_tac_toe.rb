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
    puts " #{@slots[1] || 1} | #{@slots[2] || 2} | #{@slots[3] || 3}
___ ___ ___
 #{@slots[4] || 4} | #{@slots[5] || 5} | #{@slots[6] || 6}
___ ___ ___
 #{@slots[7] || 7} | #{@slots[8] || 8} | #{@slots[9] || 9}"
  end

  def write_slot(place, symbol)
    @slots[place] = symbol unless @slots[place]
  end
end

class Player
  attr_reader :symbol, :name

  def initialize(symbol, name)
    @symbol = symbol
    @name = name
  end
end
