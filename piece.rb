
class Piece
  attr_reader :color
  attr_accessor :position, :has_moved, :move_history

  def initialize(color, position, board, move_history = nil)
  @color, @position, @board = color, position, board
    @has_moved = false
    @move_history ||= [position]
  end

  def has_moved?
    @has_moved
  end

  def to_s
    " X "
  end

  def inspect
    letters = %w(a b c d e f g h)
    "#{self} at (#{letters[position[1]]}, #{8 - position[0]})"
  end

  def dup(board)
    new_piece = self.class.new(color, position.dup, board, move_history)
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
