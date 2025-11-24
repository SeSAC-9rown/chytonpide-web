class Kit < ApplicationRecord
	belongs_to :device
	before_validation :set_defaults
	validates :kind, :name, :planted_at, :watering_interval_days, :fertilizer_interval_days, presence: true
	
	def set_defaults
		if kind.present? && kind == "바질"
			self.watering_interval_days = 7
			self.fertilizer_interval_days = 7
		end
	end
end