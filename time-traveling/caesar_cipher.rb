def caesar_cipher(string, shift)
	output = ""
	string.each_char do |i|
		if (65..90) === i.ord
			output << (((i.ord - 65 + shift) % 26) + 65).chr 	# Reduce ASCII value for i, shift it,
		elsif (96..122) === i.ord														# and account for wraparound (mod 
			output << (((i.ord - 97 + shift) % 26) + 97).chr 	# 26). Adjust back to the right ASCII
		else																								# value, and convert to character.
			output << i
		end
	end
	output
end

puts caesar_cipher("Hi, I'm Tyler!", 9)