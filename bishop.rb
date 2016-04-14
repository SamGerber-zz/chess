require_relative 'sliding_piece'

class Bishop < SlidingPiece
  def initialize(color, position, board, move_history = nil)
    @directions = [[-1, -1], [1, 1], [-1, 1], [1, -1]]
    super(color, position, @directions, board, move_history)
  end

  def to_s
    color == :black ? " ♝ " : " ♗ "
  end
end
