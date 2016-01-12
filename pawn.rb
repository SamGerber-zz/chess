require_relative 'piece.rb'

class Pawn < Piece
  def initialize(color, position, board)
    @translations = color == :black ? [[-1, 0]] : [[1, 0]]
    @captures = color == :black ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
    super(color, position, board)
  end

  # Returns an array of valid moves by checking whether each possible
  # translation is within the bounds of the board and occupied by a
  # friendly piece
  def valid_moves
    enemy_color = color == :white ? :black : :white
    translations = @translations.dup
    translations << (color == :black ? [-2, 0] : [2, 0]) unless has_moved
    moves = translations.map do |translation|
      [translation[0] + position[0], translation[1] + position[1]]
    end

    moves = moves.select do |move|
      @board.in_bounds?(move) &&
        @board.empty?(move)
    end
    @captures.each do |capture|
      move = [capture[0] + position[0], capture[1] + position[1]]
      moves << move if @board.in_bounds?(move) && @board[move].color == enemy_color
    end
    moves
  end

  def to_s
    " ♟ "
  end
end
