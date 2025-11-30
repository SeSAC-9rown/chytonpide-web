class User < ApplicationRecord
	has_one :device, dependent: :destroy
	has_many :logs, dependent: :destroy
	validates :email, uniqueness: true
	validates :email, :provider, :uid, :name, :avatar_url, presence: true
end