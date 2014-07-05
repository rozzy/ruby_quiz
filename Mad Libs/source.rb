#/usr/bin/env ruby

class Madlibs
  def add_one?
    puts "There are no Madlibs yet. Add one?"
    answer = gets.strip
    exit if answer == "n"
    add_new
  end

  def add_new
    puts "***\nYou can now add your own story. Write a madlib. To insert a placeholder use ((placeholder)) syntax. You can use multiple keywords at the time using ((keyword1:keyword2:keyword3)).——————\n"
    story = gets.strip
    puts "Okay. Now add the name:"
    name = gets.strip.downcase.gsub(/.[^\w]/, '_')
    puts "Congrats! Test the new one?"
    test_it = gets.strip
    save_story name
    return get_story name
    exit
  end

  def get_story name = false
    @dir = Dir.glob("*.mdlib")
    return add_one? if @dir.empty?
    @story = name ? File.read(name.concat ".mdlib") : random_story
    parse_story
  end

  def parse_keywords combinations
    keywords = Hash.new
    combinations.each do |key|
      key.split(":").each do |word|
        @keywords[word] = "" if !@keywords[word]
      end
    end
  end

  def parse_story
    @keywords = Hash.new
    parse_keywords @story.scan(/\({2}(.[^(]+)\){2}/i).flatten

    puts "Nice! So there are the requested words:\n\n"
    get_answers
    compile_story
  end

  def compile_story
    @orig_story = @story
    found = @story.scan(/\({2}(.[^(]+)\){2}/i).flatten
    puts "story: #{found} = #{@answers}, original story: #{@orig_story}, keywords: #{@keywords}"
  end

  def get_answers
    @answers = Hash.new
    # puts @keywords
    @keywords.each do |keyword, value|
      puts "#{keyword}:"
      @answers[keyword] = gets.strip
    end
  end

  def random_story
    File.read(@dir[Random.rand(@dir.size)])
  end

  def new_story
    story = get_story
  end

  def rules
    puts  "Hey!\n"+
          "Mad Libs is a phrasal template word game invented in the United States where one player prompts another for a list of words to substitute for blanks in a story, before reading the –often comical or nonsensical – story aloud. The game is frequently played as a party game or as a pastime.\n\n"+
          "Start a new game? (y/n)"
  end

  def initialize
    rules
    answer = gets.strip
    return new_story if answer == "y"
    puts "Ok"
    exit
  end
end

Madlibs.new
