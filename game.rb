require_relative 'board.rb'
require_relative 'display.rb'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play

    loop do
      @display.render
      input = @display.get_input
      unless input.nil?
        start = input
        end_pos = @display.get_input
        while end_pos.nil?
          @display.render
          end_pos = @display.get_input
        end
        @board.move(start, end_pos)
      end
    end

  end

end
