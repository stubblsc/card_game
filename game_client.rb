require 'socket'

require_relative 'card_game'
require_relative 'playable'

class GameClient
  include Playable

  def initialize
    @socket = TCPSocket.new('localhost', 2000)
    @timeout_thread = nil
  end

  def connect
    @socket.puts get_player_name
    puts 'waiting for players....'
    @timeout_thread = Thread.start{wait_for_other_players}
  end

  def play_game
    loop do
      read_scores
      @timeout_thread.kill

      @timeout_thread = Thread.start{wait_for_other_players}
      unless play_again?
        end_game
        break
      end

      @socket.puts 'replay'
    end
  end

  private

  def read_scores
    (CardGame::MAX_PLAYERS + 1).times do
      score = @socket.gets
    end
  end

  def wait_for_other_players
    30.times do
      sleep 1
    end

    end_game
  end

  def end_game
    @socket.puts 'close'
    @socket.close
  end
end

gc = GameClient.new
gc.connect
gc.play_game
