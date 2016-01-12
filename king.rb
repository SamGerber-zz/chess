require_relative 'stepping_piece'

class King < SteppingPiece
  def initialize(color, position, board)
    @translations = [
      [-1, -1],
      [1, 1],
      [-1, 1],
      [1, -1],
      [-1, 0],
      [1, 0],
      [0, 1],
      [0, -1]
    ]
    super(color, position, @translations, board)
  end

  def to_s
    " ♚ "
  end
end
