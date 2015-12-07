require_relative"itemcreater"
require_relative"item"
class Ai

	def initialize(itemcreater)
		@items = itemcreater.items
	end

	def choose_item
		item = rand(@items.length)
		@items[item]
	end

end