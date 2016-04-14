require_relative "sliding_piece"

class Rook < SlidingPiece

  def initialize(color, position, board, move_history = nil)
    @directions = [[-1, 0], [1, 0], [0, 1], [0, -1]]
    super(color, position, @directions, board, move_history)
  end

  def to_s
    color == :black ? " ♜ " : " ♖ "
  end
end
