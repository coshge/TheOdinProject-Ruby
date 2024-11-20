##
## The Odin Project
## Project 2 - Sub Strings
##

# Searches text for valid substrings within the given dictionary and
def substrings(text, dictionary)
    text = text.downcase
    result = Hash.new

    dictionary.each do |substring|
        count = 0
        index = 0

        while index <= text.length - substring.length do
            if text[index, substring.length] == substring
                count+=1

            end
            index+=1
        end
        result[substring] = count if count > 0
    end
    puts result
end

# Valid subtrings to search for
dictionary = [
  "hello", "there", "how", "are", "you", "yo", "the", "a", "is", 
  "in", "it", "to", "and", "she", "he", "we", "me", "at", "of", "for", 
  "with", "this", "that", "by", "on", "his", "her", "their", "them", 
  "they", "are", "ing", "ed", "ly", "un", "re", "pre", "an", "to", 
  "world", "apple", "stop", "yes", "no", "just", "more", "ever", "right"
]
user_text = ""  # String to hold user text

# # Keep asking the user for text to until they enters 'Stop'
until user_text == "Stop" do
    puts "Enter text to get the substrings"
    puts "Enter 'Stop' to stop"
    user_text = gets.chomp
    substrings(user_text, dictionary)
end
