require_relative 'piece'
require_relative 'stepping_piece'
require_relative 'sliding_piece'

class King < Piece
  include SlidingPiece
  include SteppingPiece

  def initialize(color, position, board, move_history = nil)
    @translations = SteppingPiece::KING
    super(color, position, board, move_history)
  end

  def possible_moves
    return @possible_moves if @possible_moves
    @possible_moves = possible_steps
    @possible_moves += castles if @board.current_player == color
    @possible_moves
  end

  def castles
    return [] if has_moved
    return [] if in_check?
    castles = []
    rook_positions = [[position[0], 0], [position[0], 7]]
    rook_positions.reject! do |position|
      @board[position].has_moved || !@board[position].is_a?(Rook)
    end
    rook_positions.each do |pos|
      if pos[1] > position[1]
        castles << [pos[0], 6] if   @board.empty?([pos[0], 5]) &&
                                    @board.empty?([pos[0], 6]) &&
                                    !in_check?([pos[0], 5]) &&
                                    !in_check?([pos[0], 6])
      else
        castles << [pos[0], 2] if @board.empty?([pos[0], 1]) &&
                                    @board.empty?([pos[0], 2]) &&
                                    @board.empty?([pos[0], 3]) &&
                                    !in_check?([pos[0], 2]) &&
                                    !in_check?([pos[0], 3])

      end
    end
    castles
  end

  def to_s
    color == :black ? " ♚ " : " ♔ "
  end

  def in_check?(position = nil)
    position ||= self.position
    return true if possible_steps(SteppingPiece::KNIGHT, position).any? do |move|
      piece = @board[move]
      enemy?(piece) && piece.is_a?(Knight)
    end
    return true if possible_steps(SteppingPiece::KING, position).any? do |move|
      piece = @board[move]
      enemy?(piece) && (piece.is_a?(King) ||
        (piece.is_a?(Pawn) && piece.possible_moves.include?(position)))
    end
    return true if possible_slides(SlidingPiece::RANK_AND_FILE, position).any? do |move|
      piece = @board[move]
      enemy?(piece) && (piece.is_a?(Rook) || piece.is_a?(Queen))
    end
    return true if possible_slides(SlidingPiece::DIAGONAL, position).any? do |move|
      piece = @board[move]
      enemy?(piece) && (piece.is_a?(Bishop) || piece.is_a?(Queen))
    end

    false
  end
end
