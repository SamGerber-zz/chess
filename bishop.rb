require_relative 'sliding_piece'

class Bishop < SlidingPiece
  def initialize(color, position, board)
    @directions = [[-1, -1], [1, 1], [-1, 1], [1, -1]]
    super(color, position, @directions, board)
  end

  def to_s
    " ♝ "
  end
end
