class DevicesController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def led
        device = Device.find_by!(serial: params[:serial])
        render json: {
            is_led_on: device.is_led_on,
            updated_at: Time.current.in_time_zone('Asia/Seoul').iso8601(6)
        }
    end
    
    def lcd
        device = Device.find_by!(serial: params[:serial])
        render json: {
            face: device.lcd_face,
            updated_at: Time.current.in_time_zone('Asia/Seoul').iso8601(6)
        }
    end
end