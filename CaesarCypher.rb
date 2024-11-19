##
## TEST RUBY FILE
##
def caeser_cypher(text, shift)

    lowercase_letters = "abcdefghijklmnopqrstuvwxyz"
    uppercase_letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    cyper_text = ""

    text.each_char do |char|

        if lowercase_letters.include?(char)

            index = lowercase_letters.index(char)

            shifted_index = (index + shift) % 26

            cyper_text += lowercase_letters[shifted_index]

            
        elsif uppercase_letters.include?(char)

            index = uppercase_letters.index(char)

            shifted_index = (index + shift) % 26

            cyper_text += uppercase_letters[shifted_index]

        else
            cyper_text += char
        end
    end
    cyper_text
end

puts caeser_cypher("Test string for the Caeser Cypher method", 6)
