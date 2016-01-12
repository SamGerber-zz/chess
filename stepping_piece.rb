require_relative 'piece'

class SteppingPiece < Piece

  def initialize(name, color, position, translations, board)
    @translations = translations
    super(name, color, position, board)
  end

  def valid_moves
    moves = @translations.map do |translation|
      [translation[0] + position[0], translation[1] + position[1]]
    end
    moves.select do |move|
      @board.in_bounds?(move) &&
        @board[move].color != color
    end
  end

end
