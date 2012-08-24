################################################################################
# This is an example Freeplay player.  It's very dumb, always moving
# to the first open space it can find.
class Timbot < Freeplay::Player

  ##############################################################################
  def move
    x, y = nil, nil

    # Move to the most northern space adjacent to my opponent's last move.
    if board.last_opponent_move
      logger.info("searching for an open adjacent space")

      allowed = board.adjacent(*board.last_opponent_move)
      match = allowed.find_all {|(ax, ay)| board[ax, ay] == :empty}
      x, y = match.sort.first if match
    end

    # If that didn't work just take the first empty space.
    if x.nil? or y.nil?
      logger.info("searching for first available space")

      board.size.times do |bx|
        board.size.times do |by|
          x, y = [bx, by] if board[bx, by] == :empty
        end
      end
    end
    
    # Return the desired location on the board.
    [x, y]
  end
end


