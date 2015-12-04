require_relative "item" 
class Itemcreater

	attr_accessor :items
	def initialize(info)
		@data_file = info
		@item_data = []
		@item_info = []
		@items= []
	end

	def get_info
		f = File.open(@data_file, "r")
		f.each_line do |data|
			@item_data.push(data)
		end
		puts @item_data[1]
	end

	def create_item
		@item_info = []
		@item_data.each do |d|
			d.chomp
			f = File.open(d.strip, "r")
			f.each_line do |data|
				@item_info.push(data)
			end
			@items.push(Item.new(@item_info[0], @item_info[1], @item_info[2], @item_info[3]))
		end
	end
end