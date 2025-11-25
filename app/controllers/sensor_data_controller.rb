class SensorDataController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def create
        @sensor_data = SensorData.new(
            serial: params[:serial],
            temperature: params[:temperature],
            humidity: params[:humidity],
            illuminance: params[:illuminance]
        )

        if @sensor_data.save
            # Action Cable로 실시간 브로드캐스트
            ActionCable.server.broadcast(
                "sensor_data_channel",
                serial: @sensor_data.serial,
                temperature: @sensor_data.temperature,
                humidity: @sensor_data.humidity,
                illuminance: @sensor_data.illuminance,
                timestamp: @sensor_data.created_at
            )
            render json: { status: "success" }, status: :created
        else
            render json: { status: "error" }, status: :unprocessable_entity
        end
    end
end
