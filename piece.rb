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
    "#{color} #{self.class} at #{position}"
  end

  def dup(board)
    new_piece = self.class.new(color, position.dup, board)
    new_piece.has_moved = has_moved
    new_piece
  end

  # Passed a list of possible moves and return an edited list of valid
  # moves (ones that don't expose own king to check)
  def filter_moves
    moves = possible_moves
    moves.reject do |move|
      @board.in_check?(position, move)
    end
  end

end
