require_relative 'piece'
require_relative "sliding_piece"

class Rook < Piece
  include SlidingPiece

  def initialize(color, position, board, move_history = nil)
    @directions = SlidingPiece::RANK_AND_FILE
    super(color, position, board, move_history)
  end

  def to_s
    color == :black ? " ♜ " : " ♖ "
  end
end
