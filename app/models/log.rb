class Log < ApplicationRecord
	belongs_to :user
	has_one_attached :image
	before_validation :check_logged_on_uniqueness
	validates :logged_on, :content, :image, :is_healthy, :pla, presence: true

	def check_logged_on_uniqueness
		if Log.exists?(logged_on: logged_on)
			errors.add(:logged_on, "이미 등록된 날짜입니다")
		end
	end
end