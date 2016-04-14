# require_relative 'piece'

module SteppingPiece
  KNIGHT = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]]
  KING = [[-1, -1], [1, 1], [-1, 1], [1, -1], [-1, 0], [1, 0], [0, 1], [0, -1]]
  # def initialize(color, position, translations, board, move_history = nil)
  #   @translations = translations
  #   super(color, position, board, move_history)
  # end

  # Returns an array of valid moves by checking whether each possible
  # translation is within the bounds of the board and occupied by a
  # friendly piece
  def possible_steps(translations = nil, position = nil)
    translations ||= @translations
    position ||= self.position
    moves = translations.map do |translation|
      [translation[0] + position[0], translation[1] + position[1]]
    end
    moves.select do |move|
      @board.in_bounds?(move) &&
        @board[move].color != color
    end
  end

  def possible_moves
    @possible_moves ||= possible_steps
  end
end
