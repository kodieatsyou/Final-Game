class Item
	def initialize(name, image, loses, wins)
		@name = name
		@image = image
		@loses = loses
		@wins = wins
	end

	def info
		puts @name
		puts @image
		puts @loses
		puts @wins
	end
end