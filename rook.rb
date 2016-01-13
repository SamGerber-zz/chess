require_relative "sliding_piece"

class Rook < SlidingPiece

  def initialize(color, position, board)
    @directions = [[-1, 0], [1, 0], [0, 1], [0, -1]]
    super(color, position, @directions, board)
  end

  def to_s
    color == :black ? " ♜ " : " ♖ "
  end
end
