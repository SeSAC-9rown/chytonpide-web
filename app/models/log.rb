class Log < ApplicationRecord
	belongs_to :user
	validates :logged_on, uniqueness: true
	validates :logged_on, :content, :is_healthy, :pla, presence: true
end