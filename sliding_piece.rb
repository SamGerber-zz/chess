# require_relative 'piece'

module SlidingPiece
  DIAGONAL = [[-1, -1], [1, 1], [-1, 1], [1, -1]]
  RANK_AND_FILE = [[-1, 0], [1, 0], [0, 1], [0, -1]]
  #
  # def initialize(color, position, directions, board, move_history = nil)
  #   @directions = directions
  #   super(color, position, board, move_history)
  # end


  # Returns an array of valid moves by iteratively stepping out in
  # each possible direction until it reaches a board boundary or
  # another piece.
  def possible_slides(directions = nil, position = nil)
    moves = []
    directions ||= @directions
    position ||= self.position
    directions.each do |direction|
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
  
  def possible_moves
    @possible_moves ||= possible_slides
  end
end
