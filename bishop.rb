require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece
  include SlidingPiece

  def initialize(color, position, board, move_history = nil)
    @directions = SlidingPiece::DIAGONAL
    super(color, position, board, move_history)
  end

  def to_s
    color == :black ? " ♝ " : " ♗ "
  end
end
