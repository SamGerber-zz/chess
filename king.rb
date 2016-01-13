require_relative 'stepping_piece'

class King < SteppingPiece
  def initialize(color, position, board)
    @translations = [
      [-1, -1],
      [1, 1],
      [-1, 1],
      [1, -1],
      [-1, 0],
      [1, 0],
      [0, 1],
      [0, -1]
    ]
    super(color, position, @translations, board)
  end

  def possible_moves
    moves = super
    moves += castles
  end

  def castles
    return [] if has_moved
    # return [] if @board.king_in_check?(color)
    castles = []
    rook_positions = [[position[0], 0], [position[0], 7]]
    rook_positions.reject! { |position| @board[position].has_moved }
    rook_positions.each do |pos|
      if pos[1] > position[1]
        castles << [pos[0], 6] if @board.empty?([pos[0], 5]) &&
                                    @board.empty?([pos[0], 5])
      else
        castles << [pos[0], 2] if @board.empty?([pos[0], 1]) &&
                                    @board.empty?([pos[0], 2]) &&
                                    @board.empty?([pos[0], 3])
      end
    end
    castles
  end

  def to_s
    color == :black ? " ♚ " : " ♔ "
  end
end
