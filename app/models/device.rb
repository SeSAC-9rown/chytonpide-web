class Device < ApplicationRecord
	belongs_to :user
	has_one :kit, dependent: :destroy
	before_validation :set_defaults, :check_serial_uniqueness
	validates :serial, :model, :is_led_on, :lcd_face, presence: true
	
	def check_serial_uniqueness
		if Device.exists?(serial: serial)
			errors.add(:serial, "이미 등록된 시리얼입니다")
		end
	end

	def set_defaults
		if serial.present? && serial == "xJN2wsF850yqWQfBUkGP"
			self.model = "치톤피드 프로토타입"
		elsif serial.present? && serial.start_with?("CHY")
			self.model = "치톤피드"
		end
		self.is_led_on = false
		self.lcd_face = "HAPPY"
	end
end