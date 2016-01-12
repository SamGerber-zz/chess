require_relative 'manifest'

class Board

  NULL_PIECE = NullPiece.new()

  attr_reader :grid, :size
  attr_accessor :piece_in_hand

  def initialize(size = 8)
    @size = size
    @grid = Array.new(size) { Array.new(size) { NULL_PIECE } }
    @taken_pieces = []
    @piece_in_hand = NULL_PIECE
    populate
  end

  def populate
    add_rooks
  end

  def add_rooks
    positions = [[0, 0], [0, 7], [7, 0], [7, 7]]
    positions.each do |pos|
      pos[0] == 0 ? color = :white : color = :black
      rook = Rook.new(color, pos, self)
      self[pos] = rook
    end
  end

  def move(start, end_pos)
    piece = self[start]
    place_piece(piece, end_pos)
    remove_piece(start)
    @piece_in_hand = NULL_PIECE
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
    piece.position = end_pos
  end

  def remove_piece(start)
    raise BadInputError, "Tried to remove nonexistent piece at #{start}" if self.empty?(start)
    self[start] = NULL_PIECE
  end

end
