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

  # places pieces on the board
  # => Currently return value is just the positions of the last placed piece
  def populate
    add_pieces(Rook, [[0, 0], [0, 7], [7, 0], [7, 7]])
    add_pieces(Bishop, [[0, 2], [0, 5], [7, 2], [7, 5]])
    add_pieces(Queen, [[0, 4], [7, 4]])
  end

  # Instantiate the appropriate number of rooks and add them to the board,
  # => Currently return value is just an array of the positions where the rook was placed
  def add_pieces(klass, positions)
    positions.each do |pos|
      pos[0] < 2 ? color = :white : color = :black
      piece = klass.new(color, pos, self)
      self[pos] = piece
    end
  end

  # Takes a start and end_pos, each in the form [row, column]
  # Attempts to place the piece in end_pos, putting it back in start
  # if it is unable to place it in end_pos.
  def move(start, end_pos)
    piece = self[start]
    place_piece(piece, end_pos)
    remove_piece(start)
    @piece_in_hand = NULL_PIECE
  rescue BadMoveError
    place_piece(piece, start)
  end


  # Takes a position in the form [row, column] and returns true if
  # that position on the board contains the null piece
  def empty?(pos)
    self[pos] == NULL_PIECE
  end


  # Takes a position in the form [row, column] and returns true if
  # that position is within the bounds of the board
  def in_bounds?(pos)
    pos.all? { |coord| coord.between?(0, size - 1)}
  end

  # Takes a position in the form [row, column] and returns the element
  # at that position from the grid
  def [](pos)
    row, col = pos
    grid[row][col]
  end

  # Takes a position in the form [row, column] and a piece;
  # sets the grid at position to reference the piece.
  # => Returns the piece
  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  # Takes a piece and an end_pos in the form [row, column]
  # Places the piece in a new location, if that location is valid.
  # Raises a BadMoveError if the move is invalid
  # Remembers taken piece if a piece was taken.
  def place_piece(piece, end_pos)
    raise BadMoveError, "Cannot move #{piece.class} to #{end_pos}" unless piece.valid_moves.include?(end_pos)
    @taken_pieces << self[end_pos] unless self.empty?(end_pos)
    self[end_pos] = piece
    piece.position = end_pos
  end

  # Takes a position on the board in the form [row, column]
  # Places a Null Piece at that location unless the location was empty.
  def remove_piece(start)
    raise BadInputError, "Tried to remove nonexistent piece at #{start}" if self.empty?(start)
    self[start] = NULL_PIECE
  end

end
