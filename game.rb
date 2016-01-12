require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'manifest.rb'

class Game
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
    @display = Display.new(@board)
  end


  # Infinite loop for moving pieces. Currently sort of a mess and for
  # debugging only, really.
  def play

    until board.king_in_checkmate?(:white) || board.king_in_checkmate?(:black)
      @display.render
      input = @display.get_input
      unless input.nil? || @board[input].is_a?(NullPiece)
        @board.piece_in_hand = @board[input]
        begin
          @display.render
          end_pos = @display.get_input
          while end_pos.nil?
            @display.render
            end_pos = @display.get_input
          end
          @board.move(input, end_pos)
        rescue BadMoveError
          puts "BadMoveError"
          retry
        end

      end
    end
  rescue BadInputError
    puts "BadInputError"
    @board.drop_piece
    retry

  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  # g.board.move([1, 0], [2, 0])
  # dup_g = Game.new(g.board.dup)
  g.play
end
