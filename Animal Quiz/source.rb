require 'mongo'

class AnimalQuiz
  include Mongo

  def initialize
    @DB = Connection.new.db('animal_quiz')
    new_game
  end

  def ask question
    puts question
    @answer = gets.chomp
  end

  def ask? question
    ask question
    @yes = @answer.eql? "y"
  end

  def continue? question, &block
    ask? question
    return block.call if @yes
    exit
  end

  def start_new_game?
    continue? "Start a new game? (y/n)" do
      new_game
    end
  end

  def success
    puts "Yahoo! I am pretty smart, how do you think?"
    start_new_game?
  end

  def new_game
    @conditions = {}
    puts "Think of an animal."
      # sleep 1.5

    return success if @yes
  end
end

AnimalQuiz.new
