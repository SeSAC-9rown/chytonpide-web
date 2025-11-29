class CreateLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :logs do |t|
      t.references :user, null: false, foreign_key: true
      t.date :logged_on
      t.text :content
      t.boolean :is_healthy
      t.decimal :pla

      t.timestamps
    end
  end
end
