require "gosu"
require_relative"z_order"
require_relative"cursor"
require_relative"itemcreater"
require_relative"ai"

class GameWindow < Gosu::Window

	def initialize
		super 640, 480
		self.caption = "Rock Paper Scissors V2"

		@background_image = Gosu::Image.new("media/background.png", 
																				:tileable => true)
		@curtain01 = Gosu::Image.new("media/curtain01.jpg", 
																				:tileable => true)
		@curtain02 = Gosu::Image.new("media/curtain02.jpg", 
																				:tileable => true)
		@font = Gosu::Font.new(20)
		@mainmenu = true
		@curtain01_x = 0
		@curtain02_x = 320
		@cursor = Cursor.new("media/cursor.png", self)
		itemcreater = Itemcreater.new("media/data.csv")
		itemcreater.get_info
		itemcreater.create_item
		@items = itemcreater.items
		@ai = Ai.new(itemcreater)
		@ai.choose_item
	end

	def update
		@curtain01_x -= 2
		@curtain02_x += 2
	end

	def draw
		@cursor.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		if @curtain01_x >= -320 && @curtain02_x <= 640
			@curtain01.draw(@curtain01_x, 0, ZOrder::CURTAIN)
			@curtain02.draw(@curtain02_x, 0, ZOrder::CURTAIN)
		else
			@ai.draw_chosen
		end
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end
end

window = GameWindow.new
window.show
