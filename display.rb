require 'colorize'
require_relative 'cursorable'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor = [0, 0]
  end

  # Returns the board's grid as a string
  def build_grid
    header = [" ", " a ", " b ", " c ", " d ", " e ", " f ", " g ", " h "]
    grid_display = @board.grid.map.with_index do |row, index|
      [index + 1] + build_row(row, index)
    end
    grid_display.unshift(header)
  end

  # Returns the i_th row of the board's grid as a string
  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i,j)
      piece.to_s.colorize(color_options)
    end
  end

  # Given coordinates of the form i, j generates an options hash for
  # colorize that will select the appropriate foreground and background
  # color for each cell
  # -Green for current cursor location
  # -Blue for black squares,
  # -Magenta for black squares that are valid moves of Piece in Hand
  # -Red for white squares,
  # -Light Red for white squares that are valid moves of Piece in Hand
  def colors_for(i, j)
    mode = :default
    if [i, j] == @cursor
      bg = @board.piece_in_hand.is_a?(NullPiece) ? :green : :yellow
      # mode = :blink
    # elsif @board.piece_in_hand.filter_moves.include?([i,j])
    #   bg = :white
    elsif (i + j).even?
      bg = @board.piece_in_hand.filter_moves.include?([i,j]) ? :green : :blue
    elsif (i + j).odd?
      bg = @board.piece_in_hand.filter_moves.include?([i,j]) ? :light_green : :light_red
    end

    { background: bg, color: @board[[i, j]].color, mode: mode }
  end

  # Outputs the rendered board to STDOUT
  def render
    system("clear")
    build_grid.each { |row| puts row.join }
    puts footer
  end

  def footer
    footer = []
    footer << "#{@board.current_player} is attempting to move #{@board.piece_in_hand.inspect}"
    footer << "#{@board.current_player} King is in check!!!" if @board.king_in_check?(@board.current_player)
    footer.join("\n")
  end

end
