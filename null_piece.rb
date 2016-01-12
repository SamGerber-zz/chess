require_relative 'piece'

class NullPiece < Piece

  # Give it a color just so it doesn't throw an error if we ever ask
  # for its color. Since to_s returns a blank string, this shouldn't
  # matter
  def initialize
    @color = :yellow
  end

  # Null Piece will be represented as a blank string
  def to_s
    "   "
  end

  def inspect
    ""
  end

  # Give the null piece no valid moves, in case we ever ask a piece
  # for its valid moves
  def valid_moves
    []
  end

  def dup(board)
    NullPiece.new()
  end

end
