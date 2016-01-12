class Piece
  attr_reader :name, :color, :position

  def initialize(name, color, position, board)
    @name, @color, @position, @board = name, color, position, board
    @past_moves = [position]
  end

  def to_s
    " X "
  end
end
