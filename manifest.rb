# The Game class, which handles the flow of the game
require_relative 'game.rb'
# Custom Error classes used in the other classes
require_relative 'errors.rb'

# The Display class, responsible for most output and input
require_relative 'display'
# Cursorable module is mixed into display, allowing cursor IO
require_relative 'cursorable'

# The Board class
require_relative 'board.rb'

# The Piece super class. No instances, just behavior to be inherited
require_relative 'piece.rb'
# The NullPiece class. Occupies empty squares on the board allowing polymorphic calls
require_relative 'null_piece'

# The SteppingPiece super class. These are pieces that move by
# translating a specific, limited distance, like the King and the
# Knight. No instances, just behavior to be inherited.
require_relative 'stepping_piece'


# The SlidingPiece super class. These are pieces that move by
# translating any distance in a  specified direction, like the Queen,
# Rook, and Bishop. No instances, just behavior to be inherited.
require_relative 'sliding_piece'
# The Rook class.
require_relative 'rook.rb'
# The Bishop class
require_relative 'bishop.rb'
