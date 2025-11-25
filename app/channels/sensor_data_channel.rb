class SensorDataChannel < ApplicationCable::Channel
  def subscribed
    stream_from "sensor_data_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
