require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'manifest.rb'

class Game
  attr_reader :board, :display

  def initialize(board = Board.new)
    @board = board
    @display = Display.new(@board)
  end


  # Infinite loop for moving pieces. Currently sort of a mess and for
  # debugging only, really.
  def play
    until board.king_in_checkmate?(:white) || board.king_in_checkmate?(:black) || board.stalemate?
      display.render
      input = get_start
      @board.piece_in_hand = @board[input]
      make_move(input)
      @board.switch_players!
    end
    display.render
    if board.king_in_checkmate?(:white)
      puts "White is in Checkmate\nBlack wins!"
    elsif board.king_in_checkmate?(:black)
      puts "Black is in Checkmate\nWhite wins!"
    else
      puts "Stalemate!"
    end
  rescue BadInputError, BadMoveError
    @board.drop_piece
    retry
  end


  def make_move(input)
      end_pos = get_end_point
      piece = @board.move(input, end_pos)
      if piece.is_a?(Pawn) && [0, 7].include?(piece.position[0])
        promote_pawn(piece)
      end
      @board.drop_piece
  end

  def promote_pawn(pawn)
    position = pawn.position
    display.render(true)
    current_incrementer = display.incrementer
    pieces = [Queen, Rook, Bishop, Knight]
    loop do
      @board.piece_in_hand = pieces[(display.incrementer - current_incrementer) % 4].new(pawn.color, position, @board)
      @board[position] = @board.piece_in_hand
      display.render(true)
      break if display.get_promotion_input
    end
    raise BadInputError if @board[position].is_a? Pawn
    @board.drop_piece
  end

  def get_start
    display.render
    start = display.get_input
    while invalid_input?(start)
      display.render
      start = display.get_input
    end
    start
  end

  def get_end_point
    display.render
    end_pos = display.get_input
    while end_pos.nil?
      display.render
      end_pos = display.get_input
    end
    end_pos
  end

  def invalid_input?(input)
    input.nil? || @board.current_player != @board[input].color
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  # g.board.move([1, 0], [2, 0])
  # dup_g = Game.new(g.board.dup)
  g.play
end
