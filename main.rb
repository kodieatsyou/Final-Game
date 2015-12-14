require "gosu"
require_relative"z_order"
require_relative"itemcreater"
require_relative"ai"
require_relative"control"

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
		@curtain01_x = 0
		@curtain02_x = 320
		itemcreater = Itemcreater.new("media/data.csv")
		itemcreater.get_info
		itemcreater.create_item
		@items = itemcreater.items
		@ai = Ai.new(itemcreater)
		@control = Control.new(self, @items, @ai)
		@timer = 85
		@time = Gosu::milliseconds	
	end

	def update
		@curtain01_x -= 2
		@curtain02_x += 2
		if Gosu::milliseconds > @time			
			@time = Gosu::milliseconds + @timer
			@control.arrow_control
			if @control.curstage == 1
				@control.selecting
				@control.exit_stage
			elsif @control.curstage == 2
				@control.exit_stage
			end
		end
	end

	def draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		if @curtain01_x >= -320 && @curtain02_x <= 640
			@curtain01.draw(@curtain01_x, 0, ZOrder::MENU)
			@curtain02.draw(@curtain02_x, 0, ZOrder::MENU)
		else
			@control.draw
		end
	end
end

window = GameWindow.new
window.show
