require 'colorize'
require_relative 'cursorable'
class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor = [0, 0]
  end

  def build_grid
    @board.grid.map.with_index do |row, index|
      build_row(row, index)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i,j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor
      bg = :green
    elsif (i + j).even?
      bg = @board.piece_in_hand.valid_moves.include?([i,j]) ? :magenta : :blue
    else
      bg = @board.piece_in_hand.valid_moves.include?([i,j]) ? :red : :light_red
    end
    { background: bg, color: @board[[i, j]].color }
  end

  def render
    system("clear")
    build_grid.each { |row| puts row.join }
    p @board.piece_in_hand
  end
end
