class Log < ApplicationRecord
	belongs_to :user
	has_one_attached :image
	validates :logged_on, uniqueness: { scope: :user_id }
	validates :logged_on, :content, :image, :growth_stage, :pla, presence: true
end