require_relative 'manifest'

class Board

  NULL_PIECE = Piece.new(:null, :null, [0,0], self)

  attr_reader :grid, :size

  def initialize(size = 8)
    @size = size
    @grid = Array.new(size) { Array.new(size) { NULL_PIECE } }
    @taken_pieces = []
  end

  def move(start, end_pos)
    piece = remove_piece(start)
    place_piece(piece, end_pos)
  rescue BadMoveError
    place_piece(piece, start)
  end

  def empty?(pos)
    self[pos] == NULL_PIECE
  end

  def in_bounds?(pos)
    pos.all? { |coord| coord.between?(0, size - 1)}
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def place_piece(piece, end_pos)
    raise BadMoveError, "Cannot move #{piece.name} to #{end_pos}" unless piece.valid_moves.include?(end_pos)
    @taken_pieces << self[end_pos] unless self.empty?(end_pos)
    self[end_pos] = piece
  end

  def remove_piece(start)
    raise BadInputError, "Tried to remove nonexistent piece at #{start}" if self.empty?(start)
    piece = self[start]
    self[start] = NULL_PIECE
    piece
  end

end
