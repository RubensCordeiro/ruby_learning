
#Method to clean strings of symbols and numbers & convert them all to lowcase.
def string_cleaner(string)
  pivot_string = ""
  string.each_char do |char|
    if (char.ord >= 97 && char.ord <= 122) || (char.ord >= 65 && char.ord <= 90)
      pivot_string += char.downcase
    else
      next
    end
  end
  return pivot_string
end

#Method that effectively counts ocurrence of each substring.
def substrings(strings, dictionary)
  string_array = strings.split()

  clean_strings = string_array.map {|char| string_cleaner(char)}
  clean_dictionary = dictionary.map {|char| string_cleaner(char)}

  mid_substrings = []

  clean_strings.each do |word|
    clean_dictionary.each do |item|
      mid_substrings += word.scan(string_cleaner(item))
    end
  end

  mid_substrings.reduce(Hash.new(0)) do |acum, item|
    acum[item] += 1
    acum
  end
  
end

string = "Howdy partner, sit down! How's it going?"
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings(string, dictionary)