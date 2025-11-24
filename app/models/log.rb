class Log < ApplicationRecord
	belongs_to :user
	
	before_create :set_defaults
	
	validates :title, :content, presence: true
	
	def set_defaults
		self.logged_on ||= Date.current
	end
end