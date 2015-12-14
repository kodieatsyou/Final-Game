require_relative"itemcreater"
require_relative"item"
class Ai

	attr_accessor :item
	def initialize(itemcreater)
		@items = itemcreater.items
	end

	def choose_item
		@item = rand(@items.length)
	end

	def draw
		@items[@item].draw_ai
	end
end