require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece
  include SlidingPiece

  def initialize(color, position, board, move_history = nil)
    @directions = [[-1, -1], [1, 1], [-1, 1], [1, -1], [-1, 0], [1, 0], [0, 1], [0, -1]]
    super(color, position, board, move_history)
  end

  def to_s
    color == :black ? " ♛ " : " ♕ "
  end
end
