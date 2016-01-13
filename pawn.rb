require_relative 'piece.rb'

class Pawn < Piece
  def initialize(color, position, board)
    @directions = color == :black ? [[-1, 0]] : [[1, 0]]
    @captures = color == :black ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
    super(color, position, board)
  end

  # Returns an array of valid moves by checking whether each possible
  # direction is within the bounds of the board and occupied by a
  # friendly piece
  def possible_moves
    moves = []
    calculate_directions!(moves)
    calculate_captures!(moves)
    moves
  end

  def to_s
    color == :black ? " ♟ " : " ♙ "
  end

  def calculate_directions!(moves)
    @directions.each do |direction|
      move = position
      count = has_moved ? 1 : 2
      count.times do
        move = [direction[0] + move[0], direction[1] + move[1]]
        break if !@board.in_bounds?(move) || !@board.empty?(move)
        moves << move
      end
    end
  end

  def calculate_captures!(moves)
    enemy_color = color == :white ? :black : :white

    @captures.each do |capture|
      move = [capture[0] + position[0], capture[1] + position[1]]
      moves << move if @board.in_bounds?(move) && @board[move].color == enemy_color
    end
  end

end
