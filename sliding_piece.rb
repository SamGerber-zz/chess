require_relative 'piece'

class SlidingPiece < Piece

  def initialize(color, position, directions, board)
    @directions = directions
    super(color, position, board)
  end


  # Returns an array of valid moves by iteratively stepping out in
  # each possible direction until it reaches a board boundary or
  # another piece.
  def possible_moves
    moves = []

    @directions.each do |direction|
      move = position
      loop do
        move = [direction[0] + move[0], direction[1] + move[1]]
        break if !@board.in_bounds?(move) || @board[move].color == color
        moves << move
        break unless @board.empty?(move)
      end
    end

    moves
  end

end
