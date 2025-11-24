class Kit < ApplicationRecord
	belongs_to :device
	
	before_create :set_defaults
	
	validates :kind, presence: true
	
	def set_defaults
		self.name ||= "치피"
		self.planted_at ||= Date.current

		if kind == "basil"
			self.watering_interval_days = 7
			self.fertilizer_interval_days = 7
		end
	end
end