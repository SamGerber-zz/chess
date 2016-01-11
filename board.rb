require_relative 'errors.rb'

class Board

  NullPiece = nil

  def initialize(size = 8)
    @size = size
    @grid = Array.new(size) { Array.new(size) { NullPiece } }
    @taken_pieces = []
  end

  def move(start, end_pos)
     piece = remove_piece(start)
     place_piece(piece, end_pos)
  end

  def empty?(pos)
    self[pos] == NullObject
  end


  def [](pos)
    column, y = pos
    row = @size - y - 1
    @grid[row][column]
  end

  def []=(pos, piece)
    column, y = pos
    row = @size - y - 1
    @grid[row][column] = piece
  end

  def place_piece(piece, end_pos)
    raise BadMoveError unless piece.valid_moves.include?(end_pos)
    @taken_pieces << self[end_pos] unless self.empty?(end_pos)
    self[end_pos] = piece
  end

  def remove_piece(start)
    raise BadMoveError if self.empty?(start)
    piece = self[start]
    self[start] = NullPiece
    piece
  end

end
