# Command Line Chess

This repo contains a command line chess game, written in ruby.

## Installation

To try it for yourself, clone this repo and run the file game.rb

```shell
~$ git clone https://github.com/SamGerber/chess.git
~$ ./chess/game.rb
```

## Controls

Use the arrow keys or WASD to move the cursor and space/enter to select/deselect a piece.

## Features

### Aesthetic

The game uses the colorize gem and cursorable module to create a good-looking board:

![chess-opening](./doc/opening.gif)

### Utility

Selected pieces show their possible moves, selecting an impossible move drops the piece so a new one can be selected.

![moving](./doc/moving.gif)

### Castling

The logic for castling is included with restrictions on castling through, into, or out of check:

![castling](./doc/castling.gif)

### Pawn Promotion

When a pawn reaches the other end of the board it can be promoted to a rook, bishop, knight, or queen:

![promotion](./doc/promotion.gif)

## Refactoring

### The Motivation

Recently, the game was looking like this:

![old_way](./doc/old_way.gif)

Every time we try to move a piece, too many calculations are performed and the game noticeably pauses between renders, where it just displays a black screen. This stinks.

There were several bottle-necks that needed cleaning up to get the gameplay to the smooth flow seen at the top of the page, which I'll describe below.

### The Gist

Every time we select a piece, we want to show its possible moves. In chess, it's illegal to move in such a way that you leave your king in check. That's why each of the pieces selected in the GIF below only show moves that protect the king from check.

![limit_moves](./doc/limit_moves.gif)

To accomplish this, we first find all possible moves and then filter out the moves that would leave the king in check.

Here's the code, a method on the Piece class from which all pieces inherit:

```ruby
class Piece
  ...
  # Passed a list of possible moves and return an edited list of valid
  # moves (ones that don't expose own king to check)
  def filter_moves
    moves = possible_moves
    moves.reject do |move|
      @board.in_check?(position, move)
    end
  end
end
```

In itself, this isn't so terrible, but there are two things we can improve:

1. How we determine whether the king is in check.
2. How often we calculate a piece's possible moves

### in_check?

When first writing this code, I was really concerned with separation of concerns and spent a while trying to decide where to put the logic of whether a king was in check.

Because being in check demands the coordination of several pieces and each player can only ever have one king in play, I decided it made the most sense to add a predicate method the the board class that would return true if the color passed as a parameter was in check. Here's the code:

```ruby
class board
  ...
  def king_in_check?(color)
    # Find enemy color
    enemy_color = color == :white ? :black : :white
    # Find your king's position
    king_position = find_king(color)
    # Increment over board
    can_attack?(king_position, enemy_color)
  end
end
```

The gist of this is to find the king and then check if any of the enemy pieces can attack it.

There are two ways we can speed this up:

1. Keep track of the king so we don't have to find it.
2. Instead of checking whether any enemy piece can attack the king, find squares from which an enemy piece could attack and see if an enemy piece occupies that space.

#### Keeping Track of the King

Keeping track of the king was as simple as assigning an instance variable `@kings` to a hash of `:color` and `king` pairs:

Now our `Board#find_king(color)` method has changed from this (which checks up to 64 squares):

```ruby
class board
  ...
  def find_king(color)
    grid.each do |row|
      row.each do |piece|
        return piece.position if piece.is_a?(King) && piece.color == color
      end
    end
    nil
  end
end
```

to this, which immediately returns the king's position:

```ruby
class board
  ...
  def find_king(color)
    kings[color].position
  end
end
```

#### Check by LOS

So instead of iterating over the board, finding every piece's possible moves, and then seeing if any of those include the king's current position, we want to look outward from the king's position, finding all the valid places he could be attacked from. Then we just check if the right type of attacker is in one of those places.

This approach is a clear winner in the early portion of the game, when the king is typically well guarded and can be attacked from very few squares. As pieces are removed from the board, though, it may actually be better to check each of the opponent's pieces instead of all lines of sight (LOS) to the king. We're going to switch to the LOS approach for now, and later we can see about using switching between them based on how many pieces are on the board.

### How Often We Calculate Possible Moves

Every piece responds to a `#possible_moves` method. Previously every time the method was called, the moves were recalculated. This meant every time we moved the cursor while a piece was selected, the `possible_moves` for that piece were recalculated.

A piece's `possible_moves` don't change unless a piece on the board is moved, so I refactored `#possible_moves` to assign an instance variable to its result. This means it only has to calculate the `possible_moves` once for each board state. Here's the code that makes that happen:

```ruby
class Piece
  ...
  # Passed a list of possible moves and return an edited list of valid
  # moves (ones that don't expose own king to check)
  def filter_moves
    @filter_moves ||= possible_moves.reject do |move|
      @board.in_check?(position, move)
    end
  end

  def clear_moves
    @filter_moves = @possible_moves = nil
  end
end

module SlidingPiece
  ...
  def possible_moves
    @possible_moves ||= possible_slides
  end
end

class Queen < Piece
  include SlidingPiece
  ...
end
```

In order to force every piece to recalculate its possible_moves when the board changes, `Piece#clear_moves` was called on every piece when the board switched players:

```ruby
class Board
  def switch_players!
    grid.each do |row|
      row.each do |square|
        square.clear_moves
      end
    end
    self.current_player = (current_player== :white) ? :black : :white
  end
end
```

This combination of refactorings led to a much more playable experience.
