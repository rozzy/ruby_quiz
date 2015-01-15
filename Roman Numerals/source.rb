#!/usr/bin/ruby

def get_max_num
  {
    'M' => 1_000,
    'D' => 500,
    'C' => 100,
    'L' => 50,
    'XII' => 12,
    'XI' => 11,
    'X' => 10,
    'IX' => 9,
    'VIII' => 8,
    'VII' => 7,
    'VI' => 6,
    'V' => 5,
    'IV' => 4,
    'III' => 3,
    'II' => 2,
    'I' => 1,
  }
end

def parse_input_string input
  nums = get_max_num
  nums.each do |key, value|
    key = key.upcase
    input.gsub!(/#{key}/, value.to_s) if input.include? key and input.respond_to? :gsub!
  end if nums.respond_to? :each
  input
end

def is_roman? input
  input.eql? ""
end

def is_arabic? input
  not is_roman?
end

def run!
  puts "Enter the arabic or roman number:\n"
  input = gets.chomp!.upcase!
  parse_input_string input
end

puts run!
