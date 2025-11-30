class CreateDevices < ActiveRecord::Migration[8.1]
  def change
    create_table :devices do |t|
      t.references :user, null: false, foreign_key: true
      t.string :serial
      t.string :model
      t.string :led_mode
      t.boolean :is_led_on
      t.string :lcd_face

      t.timestamps
    end
  end
end
