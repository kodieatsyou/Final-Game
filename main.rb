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
		@startbutn = Gosu::Image.new("media/start.png")
		@createbutn = Gosu::Image.new("media/create.png")
		@menuarrow = Gosu::Image.new("media/arrow.png")
		itemcreater = Itemcreater.new("media/data.csv")
		itemcreater.get_info
		itemcreater.create_item
		@items = itemcreater.items
		@ai = Ai.new(itemcreater)
		@ai.choose_item
		@arrowpos = 0
	end

	def update
		@curtain01_x -= 2
		@curtain02_x += 2
		@arrowpos += 1 if Gosu::button_down? Gosu::KbDown
		if @arrowpos > 2
			@arrowpos = 0
		end
	end

	def draw
		@cursor.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		if @curtain01_x >= -320 && @curtain02_x <= 640
			@curtain01.draw(@curtain01_x, 0, ZOrder::MENU)
			@curtain02.draw(@curtain02_x, 0, ZOrder::MENU)
		else
			draw_menu
		end
	end

	def draw_menu
		@startbutn.draw(self.width / 2 - 32, self.height / 2 - 96, ZOrder::MENU)
		@createbutn.draw(self.width / 2 - 32, self.height / 2 - 48, ZOrder::MENU)
		if @arrowpos == 0
			@menuarrow.draw(self.width / 2 + 32, self.height / 2 - 96, ZOrder::MENU)
		elsif @arrowpos == 2
			@menuarrow.draw(self.width / 2 + 32, self.height / 2 - 48, ZOrder::MENU)
		end
	end
end

window = GameWindow.new
window.show
