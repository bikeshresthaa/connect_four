require_relative 'board'
require_relative 'player'
require_relative 'game'

def play_connect_four
  puts "Welcome to connect four!!"
  puts "Player1 Enter your name: "
  name1 = gets.chomp
  puts "Player2 Enter your name: "
  name2 = gets.chomp

  player1 = Player.new(name1, '🔴')
  player2 = Player.new(name2, '🟡')
  game = Game.new(player1, player2)
  
  game.play
end

play_connect_four