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

    def update
        device = Device.find_by!(serial: params[:serial])
        
        update_params = {}
        update_params[:lcd_face] = params[:lcd_face] if params[:lcd_face].present?
        update_params[:is_led_on] = params[:is_led_on] if params[:is_led_on].present?
        
        if update_params.empty?
          render json: { 
            status: 'error', 
            message: 'lcd_face or is_led_on parameter is required' 
          }, status: :bad_request
          return
        end
        
        if device.update(update_params)
          render json: {
            status: 'success',
            lcd_face: device.lcd_face,
            is_led_on: device.is_led_on,
            updated_at: Time.current.in_time_zone('Asia/Seoul').iso8601(6)
          }
        else
          render json: {
            status: 'error',
            errors: device.errors.full_messages
          }, status: :unprocessable_entity
        end
    end
end
