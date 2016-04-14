require 'colorize'
require_relative 'cursorable'

class Display
  include Cursorable
  attr_reader :incrementer, :highlight

  def initialize(board)
    @board = board
    @cursor = [0, 0]
    @incrementer = 0
    @highlight = true
  end

  # Returns the board's grid as a string
  def build_grid
    header = [" ", " a ", " b ", " c ", " d ", " e ", " f ", " g ", " h "]
    grid_display = @board.grid.map.with_index do |row, index|
      [8 - index] + build_row(row, index)
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

  def colors_for(i, j)
    mode = :default
    if [i, j] == @cursor
      bg = @board.piece_in_hand.is_a?(NullPiece) ? :yellow : :light_blue
      # mode = :blink
    # elsif @board.piece_in_hand.filter_moves.include?([i,j])
    #   bg = :white
  elsif (i + j).odd?
      bg = :white
      bg = :green if highlight && @board.piece_in_hand.filter_moves.include?([i,j])
    elsif (i + j).even?
      bg = :light_white
      bg = :light_green if highlight && @board.piece_in_hand.filter_moves.include?([i,j])
    end

    { background: bg, color: :black, mode: mode } #@board[[i, j]].color
  end

  # Outputs the rendered board to STDOUT
  def render(promotion = false)
    @highlight = false if promotion
    system("clear")
    puts " #{build_piece_bank(:white)[0]}"
    puts " #{build_piece_bank(:white)[1]}"
    build_grid.each { |row| puts row.join }
    puts footer
    puts "Press TAB to choose".colorize(color: :red) if promotion
    puts "Press and ENTER to confirm".colorize(color: :red) if promotion
    @highlight = true
  end

  def footer
    footer = []
    footer << " #{@board.current_player} is moving..."
    footer << " #{@board.piece_in_hand.inspect} to #{beautify_position(@cursor)}" unless @board.piece_in_hand.is_a?(NullPiece)
    footer << " #{@board.current_player} King is in check!!" if @board.king_in_check?(@board.current_player)
    footer << " #{build_piece_bank(:black)[0]}"
    footer << " #{build_piece_bank(:black)[1]}"
    # footer << @board.taken_pieces.join(" ")
    footer.join("\n")
  end

  def beautify_position(position)
    letters = %w(a b c d e f g h)
    "(#{letters[position[1]]}, #{8 - position[0]})"
  end

  def build_piece_bank(color)
    bank = Array.new(2) { Array.new(8, "   ") }

    pieces = @board.taken_pieces.select do |piece|
      piece.color == color
    end

    pieces.each_with_index do |piece, i|
      bank[i / 8][i - 8] = piece
    end

    bank.map do |row|
      row.join.to_s.colorize(bank_color_options(color))
    end

  end

  def bank_color_options(color)
    bg = color == :white ? :light_black : :light_white
    { background: bg, color: color}
  end


end
