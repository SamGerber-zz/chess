class Piece
  attr_reader :color
  attr_accessor :position

  def initialize(color, position, board)
  @color, @position, @board = color, position, board
    @past_moves = [position]
  end

  def to_s
    " X "
  end

  def inspect
    "#{color} #{self.class} at #{position}"
  end
end
