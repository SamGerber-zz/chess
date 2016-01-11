require_relative 'piece'

class NullPiece < Piece

  def initialize

  end

  def to_s
    "   "
  end

  def inspect
    "NullPiece"
  end

end
