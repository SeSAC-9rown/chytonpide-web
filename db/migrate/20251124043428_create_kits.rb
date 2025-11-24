class CreateKits < ActiveRecord::Migration[8.1]
  def change
    create_table :kits do |t|
      t.references :device, null: false, foreign_key: true
      t.string :kind
      t.string :name
      t.date :planted_at
      t.integer :watering_interval_days
      t.integer :fertilizer_interval_days

      t.timestamps
    end
  end
end
