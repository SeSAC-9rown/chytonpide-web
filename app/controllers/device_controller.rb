class DeviceController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    # QR 코드 스캔 페이지
    def new
        @user = current_user
    end
    
    # 시리얼 넘버로 디바이스 생성
    def create
        @user = current_user
        @device = @user.build_device(device_params)
        
        if @device.save
            # 키트 데이터 함께 생성
            @device.create_kit(
                kind: "바질",
                name: "치피",
                planted_at: Date.today
            )
            
            render json: {
                success: true,
                message: '디바이스가 등록되었습니다!',
                device: { serial: @device.serial }
            }
        else
            render json: {
                success: false,
                message: '디바이스 등록 실패',
                errors: @device.errors.full_messages
            }, status: :unprocessable_entity
        end
    end

    def update
        @device = current_user.device
      
        Rails.logger.info "DEVICE UPDATE params: #{params.inspect}"
        Rails.logger.info "BEFORE: #{@device.attributes.slice('led_mode','is_led_on','lcd_face')}"
      
        if @device.update(device_update_params)
          Rails.logger.info "AFTER:  #{@device.attributes.slice('led_mode','is_led_on','lcd_face')}"
          render json: { status: 'success', message: '디바이스가 업데이트되었습니다.' }
        else
          Rails.logger.error "UPDATE ERRORS: #{@device.errors.full_messages}"
          render json: { status: 'error', message: '업데이트 실패', errors: @device.errors.full_messages },
                 status: :unprocessable_entity
        end
    end      
    
    private

    def device_params
        params.require(:device).permit(:serial)
    end

    def device_update_params
        # is_led_on 컬럼이 boolean 타입이라고 가정
        {
          led_mode:  params[:led_mode],
          lcd_face:  params[:lcd_face],
          is_led_on: ActiveModel::Type::Boolean.new.cast(params[:is_led_on]) # "true"/"false" → true/false
        }
      end
end