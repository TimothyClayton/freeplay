class Timbot < Freeplay::Player

  ##############################################################################
  def move
    x, y = 0, 0

    # Move to a random empty space adjacent to my opponent's last move.
    if board.last_opponent_move
      logger.info("searching for the last empty adjacent space")

      allowed = board.adjacent(*board.last_opponent_move)
      match = allowed.find_all {|(ax, ay)| board[ax, ay] == :empty}
      x, y = match.sort.sample if match
    end

    # If that didn't work move to last empty space on the board.
    if x.nil? or y.nil?
      logger.info("searching for last empty space on the board")
      
      @empty_spaces = []
      board.size.times do |bx|
        board.size.times do |by|
          @empty_spaces << [bx, by] if board[bx, by] == :empty
        end
      end
      
      puts(@empty_spaces.join(', '))      
      x, y = @empty_spaces.last
      puts x, y
    end
    
    # Return the desired location on the board.
    [x, y]
  end
end
