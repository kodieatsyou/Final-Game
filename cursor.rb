class Cursor
	def initialize(image, window)
		@image = Gosu::Image.new(image)
		@window = window
	end

	def draw
		@image.draw(@window.mouse_x, @window.mouse_y, ZOrder::CURSOR)
	end
end