class Device < ApplicationRecord
	belongs_to :user
	has_one :kit, dependent: :destroy
	before_validation :set_defaults
	validates :serial, uniqueness: true
	validates :serial, :model, presence: true
	
	def set_defaults
		if serial.present? && serial == "xJN2wsF850yqWQfBUkGP"
			self.model = "치톤피드 프로토타입"
		elsif serial.present? && serial.start_with?("CHY")
			self.model = "치톤피드"
		end
	end
end