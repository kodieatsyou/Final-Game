require_relative "item" 
class Itemcreater

	attr_accessor :items
	def initialize(file)
		@file = file
		@data = []
		@items= []
	end

	def create_items
		f = File.open(@file, "r")
		f.each_line do |data|
			data = data.split('\n')
			puts data
			#@users.push(User.new(data[0], data[1].to_i, data[2].to_i))
		end
	end

end