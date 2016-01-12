require_relative 'piece'

class SteppingPiece < Piece

  def initialize(color, position, translations, board)
    @translations = translations
    super(color, position, board)
  end

  # Returns an array of valid moves by checking whether each possible
  # translation is within the bounds of the board and occupied by a
  # friendly piece
  def possible_moves
    moves = @translations.map do |translation|
      [translation[0] + position[0], translation[1] + position[1]]
    end
    moves.select do |move|
      @board.in_bounds?(move) &&
        @board[move].color != color
    end
  end

end
