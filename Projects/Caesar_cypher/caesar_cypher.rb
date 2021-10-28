#Displaces character on the alphabet.
def displace_char(char, alphabet = ('a'..'z').to_a, displacement)
  char = char.downcase()
  indexed_alphabet = {}
  alphabet.each_with_index do |letter, index|
    indexed_alphabet[letter] = index + 1
  end

  letter_index = indexed_alphabet[char]
  total_displacement = letter_index + displacement
  displaced_index = total_displacement > 26 ? (total_displacement - 26) : total_displacement
  letter_hash = indexed_alphabet.filter {|key, value| value == displaced_index}
  return alphabet[letter_hash.values[0] - 1]
end

#Checks if character is blank space
def is_blank_space?(char)
  char.ord == 32
end

#Checks if character is a letter using the ASCII table.
def is_letter?(char)
  (char.ord >= 97 && char.ord <= 122) || (char.ord >= 65 && char.ord <= 90)
end

#Run the encrypting
def cypher(string, displacement)
  encrypted_string = ""
  string.each_char do |char|
 
    #If char is letter, proceed with displacement, if not returns whichever data
    #is stored on char.
    if !is_letter?(char)
      is_blank_space?(char) ? encrypted_string += " " : encrypted_string += char
      next
    end

    new_char = displace_char(char, displacement)
    new_char = char == char.upcase() ? new_char.upcase() : new_char
    encrypted_string += new_char
  end

  return encrypted_string

end

puts cypher("What a string!", 5)

# puts displace_char("W", 4)