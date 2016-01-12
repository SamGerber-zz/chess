require_relative 'piece'

class NullPiece < Piece

  def initialize
    @color = :yellow
  end

  def to_s
    "   "
  end

  def inspect
    "NullPiece"
  end

  def valid_moves
    []
  end

end
