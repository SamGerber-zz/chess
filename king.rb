require_relative 'stepping_piece'

class King < SteppingPiece
  def initialize(color, position, board, move_history = nil)
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
    super(color, position, @translations, board, move_history)
  end

  def possible_moves
    moves = super
    moves += castles if @board.current_player == color
    moves
  end

  def castles
    return [] if has_moved
    enemy_color = color == :white ? :black : :white
    return [] if @board.can_attack?(position, enemy_color)
    castles = []
    rook_positions = [[position[0], 0], [position[0], 7]]
    rook_positions.reject! do |position|
      @board[position].has_moved || !@board[position].is_a?(Rook)
    end
    rook_positions.each do |pos|
      if pos[1] > position[1]
        castles << [pos[0], 6] if   @board.empty?([pos[0], 5]) &&
                                    @board.empty?([pos[0], 6]) &&
                                    !@board.can_attack?([pos[0], 5], enemy_color) &&
                                    !@board.can_attack?([pos[0], 6], enemy_color)
      else
        castles << [pos[0], 2] if @board.empty?([pos[0], 1]) &&
                                    @board.empty?([pos[0], 2]) &&
                                    @board.empty?([pos[0], 3]) &&
                                    !@board.can_attack?([pos[0], 2], enemy_color) &&
                                    !@board.can_attack?([pos[0], 3], enemy_color)

      end
    end
    castles
  end

  def to_s
    color == :black ? " ♚ " : " ♔ "
  end
end
