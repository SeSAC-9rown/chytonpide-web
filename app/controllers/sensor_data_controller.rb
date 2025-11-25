class SensorDataController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def create
        # 1. 들어온 데이터로 임시 객체 생성 (검증용)
        @sensor_datum = SensorDatum.new(
            serial: params[:serial],
            temperature: params[:temperature],
            humidity: params[:humidity],
            illuminance: params[:illuminance]
        )

        # 2. 데이터 검증 (유효성 체크)
        if @sensor_datum.valid?
            # 3. 마지막 저장 시간 확인
            last_record = SensorDatum.where(serial: params[:serial])
                                     .order(created_at: :desc)
                                     .first
            
            should_save = if last_record.nil?
                # 첫 데이터는 무조건 저장
                true
            else
                # 마지막 저장 시간으로부터 30분 이상 경과했는지 확인
                (Time.current - last_record.created_at) >= 30.minutes
            end

            # 4. 조건에 맞으면 DB에 저장
            if should_save
                @sensor_datum.save
                Rails.logger.info "💾 DB 저장됨: #{@sensor_datum.serial}"
            else
                Rails.logger.info "⏭️  DB 저장 스킵 (30분 미경과)"
            end

            # 5. 실시간 브로드캐스트는 항상 수행 (검증된 모든 데이터)
            ActionCable.server.broadcast(
                "sensor_data_channel",
                {
                    serial: @sensor_datum.serial,
                    temperature: @sensor_datum.temperature,
                    humidity: @sensor_datum.humidity,
                    illuminance: @sensor_datum.illuminance,
                    timestamp: Time.current,
                    saved_to_db: should_save  # DB 저장 여부 표시 (선택사항)
                }
            )

            render json: { 
                status: "success", 
                saved_to_db: should_save 
            }, status: :created
        else
            # 6. 검증 실패 시
            Rails.logger.warn "❌ 검증 실패: #{@sensor_datum.errors.full_messages}"
            render json: { 
                status: "error", 
                errors: @sensor_datum.errors.full_messages 
            }, status: :unprocessable_entity
        end
    end
end
