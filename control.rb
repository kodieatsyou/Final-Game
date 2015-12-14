require_relative "z_order"
require_relative "itemcreater"
require_relative "ai"
require_relative "item"
class Control
	attr_accessor :curstage
	def initialize(window, items, ai)
		@mainmenu = true
		@width = window.width
		@height = window.height
		@items = items
		@ai = ai
		@curstage = 0 #0 = mainmenu, 1 = play, 2 = create
		@curitem = 1
		@selected = nil
		@arrowpos = 0
		@font = Gosu::Font.new(30)
		@startbutn = Gosu::Image.new("media/start.png")
		@createbutn = Gosu::Image.new("media/create.png")
		@menuarrow = Gosu::Image.new("media/arrow.png")
		@ai_item = nil
		@winner = nil #1 = player 2 = ai
	end

	def draw
		if @curstage == 1
			play
		elsif @curstage == 2
			create
		elsif @curstage == 0
			main_menu
		elsif @curstage == 3
			battle
		end
	end

	def main_menu
		@font.draw("Rock Paper Scissors!", @width / 2 - 105, @height / 2 - 100, ZOrder::UI, 1.0, 1.0, 0xff_00FF15)
		@startbutn.draw(@width / 2 - 32, @height / 2 -48, ZOrder::MENU)
		@createbutn.draw(@width / 2 - 32, @height / 2 , ZOrder::MENU)
		if @arrowpos == 0
			@menuarrow.draw(@width / 2 - 64, @height / 2 - 48, ZOrder::MENU)
		elsif @arrowpos == 1
			@menuarrow.draw(@width / 2 - 64, @height / 2, ZOrder::MENU)
		end
	end

	def play
		@font.draw("Choose your item!", @width / 2 - 90, @height / 2 - 100, ZOrder::UI, 1.0, 1.0, 0xff_00FF15)
		@items[@curitem].draw_select
	end

	def create
		@font.draw("Create an item!", @width / 2 - 90, @height / 2 - 100, ZOrder::UI, 1.0, 1.0, 0xff_00FF15)
	end

	def arrow_control
		@arrowpos += 1 if Gosu::button_down? Gosu::KbDown
		@arrowpos -= 1 if Gosu::button_down? Gosu::KbUp
		if @arrowpos > 1
			@arrowpos = 0
		elsif @arrowpos < 0 
			@arrowpos = 1
		end
		if @arrowpos == 0 
			@curstage = 1 if Gosu::button_down? Gosu::KbSpace
		elsif @arrowpos == 1 
			@curstage = 2 if Gosu::button_down? Gosu::KbSpace
		end
	end

	def exit_stage
		if Gosu::button_down? Gosu::KbEscape
			@curstage = 0
		end		
	end

	def selecting
		@curitem += 1 if Gosu::button_down? Gosu::KbRight
		@curitem -= 1 if Gosu::button_down? Gosu::KbLeft
		if @curitem > @items.length - 1
			@curitem = 0
		elsif @curitem < 0
			@curitem = @items.length - 1
		end
		if Gosu::button_down? Gosu::KbSpace
			@selected = @items[@curitem]
			@curstage = 3
			@ai.choose_item
			@ai_item = @ai.item
		end
	end	

	def battle
		@font.draw("Fight!", @width / 2 - 40, @height / 2 - 150, ZOrder::UI, 1.0, 1.0, 0xff_00FF15)
		@selected.draw_player
		@ai.draw
		check_winner
	end

	def check_winner
		@selected.info
		# @selected.loses = loses
		# loses.each do |i|
		# 	if i == @ai_item
		# 		@winner = 2
		# 		puts "hi"
		# 	end
		# end
		# wins.each do |i|
		# 	if i == @ai_item
		# 		@winner = 1
		# 		puts "heloo"
		# 	end
		# end
	end
end