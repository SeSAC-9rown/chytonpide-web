class SensorDataController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def create
        @sensor_datum = SensorDatum.new(
            serial: params[:serial],
            temperature: params[:temperature],
            humidity: params[:humidity],
            illuminance: params[:illuminance]
        )

        if @sensor_datum.save
            # Action Cable로 실시간 브로드캐스트
            ActionCable.server.broadcast(
                "sensor_data_channel",
                {  # 여기에 중괄호 추가!
                    serial: @sensor_datum.serial,
                    temperature: @sensor_datum.temperature,
                    humidity: @sensor_datum.humidity,
                    illuminance: @sensor_datum.illuminance,
                    timestamp: @sensor_datum.created_at
                }
            )
            render json: { status: "success" }, status: :created
        else
            render json: { status: "error" }, status: :unprocessable_entity
        end
    end
end
