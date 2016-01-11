class Piece
  attr_reader :name, :color, :position

  def initialize(name, color, position)
    @name, @color, @position = name, color, position
  end

  def to_s
    " X "
  end
end
