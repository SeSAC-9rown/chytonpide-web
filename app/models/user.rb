class User < ApplicationRecord
	has_one :device, dependent: :destroy

	validates :name, :provider, :uid, presence: true
	validates :email, presence: true, uniqueness: true
end