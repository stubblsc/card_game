# How To
# Local Game
Run the game by running `ruby main.rb` in your console. Enter each of the 5 players names and you'll get the score.
Afterwards, you can decide to play another game or stop.

# Remote Game
Run the server by running `ruby game_server.rb` in your console. Then you can start 5 clients with `ruby game_client.rb`.
Once the 5 clients are running, the game should start. After each game completes, each player will need to opt back in
to play again. If players opt out, more players/clients will need to join in order to continue. Timeout happens if any
user doesn't provide input for 30 seconds when expected.

# Todo:
1. Cleanup timeouts implementation
2. Cleanup & refactor client/server implementation
3. Improved error handling for client/server implementation
4. Tests
