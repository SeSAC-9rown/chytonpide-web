class Device < ApplicationRecord
	belongs_to :user
	has_one :kit, dependent: :destroy
	validates :model, :serial, :wifi_ssid, :wifi_password, presence: true
end