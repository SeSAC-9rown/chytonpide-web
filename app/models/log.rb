class Log < ApplicationRecord
	belongs_to :user
	validates :logged_on, uniqueness: true
	validates :logged_on, :content, presence: true
end