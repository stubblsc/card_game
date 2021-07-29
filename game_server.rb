require 'socket'

require_relative 'player'
require_relative 'card_game'

class GameServer
  TIMEOUT = 30

  def initialize
    @server_socket = TCPServer.open(2000)
    @threads = []
    @conns = []
    @game_manager = CardGame.new
  end

  def run_server
    loop do
      spawn_needed_threads

      next if play_game
      cleanup_threads
    end
  end

  private

  def cleanup_threads
    @threads.map(&:kill)
    @conns.map(&:close)
    @conns = []
    @threads = []
  end

  def spawn_needed_threads
    while @threads.size < CardGame::MAX_PLAYERS
      @threads << Thread.new(@server_socket.accept) do |conn|
        @conns << conn
        until name = conn.gets&.chomp; end
        player = @game_manager.add_player(name)

        loop do
          Thread.stop

          @game_manager.game_results.each do |result|
            conn.puts result
          end

          until continue_response = conn.gets&.chomp; end

          @continue_responses += 1

          Thread.stop

          unless continue_response == 'replay'
            @game_manager.remove_player(player)
            @threads.delete(Thread.current)
            conn.close
            break
          end
        end
      end
    end
  end

  def play_game
    timeout = TIMEOUT
    while @game_manager.player_count < CardGame::MAX_PLAYERS do
      return false if timeout == 0
      sleep 1
      timeout -= 1
    end

    @game_manager.start_game
    @game_manager.deal_cards

    @continue_responses = 0

    @threads.map(&:run)

    timeout = 5
    while @continue_responses < CardGame::MAX_PLAYERS do
      return false if timeout == 0
      sleep 1
      timeout -= 1
    end

    @threads.map(&:run)

    true
  end
end

class TimeoutError < StandardError; end

gs = GameServer.new
gs.run_server
