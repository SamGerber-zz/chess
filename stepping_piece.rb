# require_relative 'piece'

module SteppingPiece

  # def initialize(color, position, translations, board, move_history = nil)
  #   @translations = translations
  #   super(color, position, board, move_history)
  # end

  # Returns an array of valid moves by checking whether each possible
  # translation is within the bounds of the board and occupied by a
  # friendly piece
  def possible_steps
    moves = @translations.map do |translation|
      [translation[0] + position[0], translation[1] + position[1]]
    end
    moves.select do |move|
      @board.in_bounds?(move) &&
        @board[move].color != color
    end
  end

  alias_method :possible_moves, :possible_steps
end
