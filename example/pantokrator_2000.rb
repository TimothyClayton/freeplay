class Timbot < Freeplay::Player

  ##############################################################################
  def move
    x, y = nil, nil

    # Move to the last empty space adjacent to my opponent's last move.
    if board.last_opponent_move
      logger.info("searching for an open adjacent space")

      allowed = board.adjacent(*board.last_opponent_move)
      match = allowed.find_all {|(ax, ay)| board[ax, ay] == :empty}
      x, y = match.sort.last if match
    end

    # If that didn't work move to random empty space on the board.
    if x.nil? or y.nil?
      logger.info("searching for random empty space")

      @empty_spaces = []
      board.size.times do |bx|
        board.size.times do |by|
          @empty_spaces << [bx, by] if board[bx, by] == :empty
        end
      end

      puts(@empty_spaces.join(', '))
      x, y = @empty_spaces.sample
      puts x, y
    end

    # Return the desired location on the board.
    [x, y]
  end
end
