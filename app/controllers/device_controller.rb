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
    
    private
    
    def device_params
        params.require(:device).permit(:serial)
    end
end