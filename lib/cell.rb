require_relative '../lib/water'

class Cell
	attr_accessor :content, :hit
	def initialize
		@hit = false
		@content = Water.new
	end

	def shoot
		@hit = content.hit!
	end

	def hit?
		@hit
	end
end