require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'manifest.rb'

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
        @board.piece_in_hand = @board[input]
        @display.render
        end_pos = @display.get_input
        while end_pos.nil?
          @display.render
          end_pos = @display.get_input
        end
        @board.move(start, end_pos)
      end
    end
  rescue BadInputError
    retry
  rescue BadMoveError
    retry

  end

end