class Item
	def initialize(name, image, loses, wins)
		@name = name
		@image = image.chomp
		@loses = loses
		@wins = wins
		@item_image = Gosu::Image.new("media/#{@image}")

	end

	def info
		puts @name
		puts @image
		puts @loses
		puts @wins
	end

	def draw_player
		@item_image.draw(100, 480 / 2, ZOrder::PLAYER)
	end

	def draw_ai
		@item_image.draw(440, 480 / 2, ZOrder::PLAYER)
	end

	def draw_select
		@item_image.draw(640 / 2 - 32, 480 / 2 - 32, ZOrder::PLAYER)
	end

end