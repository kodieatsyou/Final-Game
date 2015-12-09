require "gosu"
require_relative"z_order"
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
		@font = Gosu::Font.new(30)
		@mainmenu = true
		@curtain01_x = 0
		@curtain02_x = 320
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
		@timer = 85
		@time = Gosu::milliseconds
		@playing = false
		@selecting = false
		@creating = false
		@curitem = 1
		@selected = nil
	end

	def update
		@curtain01_x -= 2
		@curtain02_x += 2
		if Gosu::milliseconds > @time			
			@time = Gosu::milliseconds + @timer
			@arrowpos += 1 if Gosu::button_down? Gosu::KbDown
			@arrowpos -= 1 if Gosu::button_down? Gosu::KbUp
			if @selecting 
				@curitem += 1 if Gosu::button_down? Gosu::KbRight
				@curitem -= 1 if Gosu::button_down? Gosu::KbLeft
				if @curitem > @items.length - 1
					@curitem = 0
				elsif @curitem < 0
					@curitem = @items.length - 1
				end
				if Gosu::button_down? Gosu::KbSpace
					@selected = @curitem 
					@playing = true
					@selecting = false
				end
			end
			if @arrowpos > 1
					@arrowpos = 0
			elsif @arrowpos < 0 
					@arrowpos = 1
			end
			if @arrowpos == 0 
				@selecting = true if Gosu::button_down? Gosu::KbSpace
			elsif @arrowpos == 1 
				@creating = true if Gosu::button_down? Gosu::KbSpace
			end
			if @playing || @creating and Gosu::button_down? Gosu::KbEscape
				@selecting = false
				@creating = false
				@mainmenu = true
			end			
		end
	end

	def draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		if @mainmenu == true
			if @curtain01_x >= -320 && @curtain02_x <= 640
				@curtain01.draw(@curtain01_x, 0, ZOrder::MENU)
				@curtain02.draw(@curtain02_x, 0, ZOrder::MENU)
			else
				draw_menu
			end
		end
		if @selecting
			select
		elsif @creating 
			create
		elsif @playing 
			play
		end			
	end

	def draw_menu
		@startbutn.draw(self.width / 2 - 32, self.height / 2 - 96, ZOrder::MENU)
		@createbutn.draw(self.width / 2 - 32, self.height / 2 - 48, ZOrder::MENU)
		if @arrowpos == 0
			@menuarrow.draw(self.width / 2 - 64, self.height / 2 - 96, ZOrder::MENU)
		elsif @arrowpos == 1
			@menuarrow.draw(self.width / 2 - 64, self.height / 2 - 48, ZOrder::MENU)
		end
	end

	def select
		@mainmenu = false
		@font.draw("Choose your item!", self.width / 2 - 90, self.height / 2 - 100, ZOrder::UI, 1.0, 1.0, 0xff_00FF15)
		@items[@curitem].draw_select
	end

	def create
		@mainmenu = false
	end

	def play
		puts "yo"
	end

end

window = GameWindow.new
window.show
