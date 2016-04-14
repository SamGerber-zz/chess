require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPiece

  def initialize(color, position, board, move_history = nil)
    @translations = SteppingPiece::KNIGHT
    super(color, position, board, move_history = nil)
  end

  def to_s
    color == :black ? " ♞ " : " ♘ "
  end
end
