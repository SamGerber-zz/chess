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
      bg = :magenta
    else
      bg = :red
    end
    { background: bg, color: :white }
  end

  def render
    system("clear")
    build_grid.each { |row| puts row.join }
  end
end
