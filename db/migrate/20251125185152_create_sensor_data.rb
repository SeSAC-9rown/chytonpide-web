class CreateSensorData < ActiveRecord::Migration[8.1]
  def change
    create_table :sensor_data do |t|
      t.string :serial
      t.float :temperature
      t.float :humidity
      t.float :illuminance

      t.timestamps
    end
  end
end
