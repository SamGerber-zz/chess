class Piece
  attr_reader :color
  attr_accessor :position, :has_moved

  def initialize(color, position, board)
  @color, @position, @board = color, position, board
    @has_moved = false
  end

  def has_moved?
    @has_moved
  end



  def to_s
    " X "
  end

  def inspect
    "#{color} #{self.class} at #{position} (#{has_moved})"
  end
end
