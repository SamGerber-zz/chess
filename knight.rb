require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPiece

  def initialize(color, position, board, move_history = nil)
    @translations = [
      [1, 2],
      [-1, 2],
      [1, -2],
      [-1, -2],
      [2, 1],
      [-2, 1],
      [2, -1],
      [-2, -1]
    ]
    super(color, position, board, move_history = nil)
  end

  def to_s
    color == :black ? " ♞ " : " ♘ "
  end
end
