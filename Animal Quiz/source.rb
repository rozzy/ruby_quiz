require 'redis'

class AnimalQuiz
  def initialize
    @DB = Redis.new(:hostname => "localhost", :port => 6379)
    new_game
  end

  def ask question
    puts question
    @answer = gets.chomp
  end

  def continue? question, &block
    ask question
    return block.call if @answer == "y"
    exit
  end

  def start_new_game?
    continue? "Start a new game? (y/n)" do
      new_game
    end
  end

  def new_game
    ask "Think of an animal:"

  end
end

AnimalQuiz.new
