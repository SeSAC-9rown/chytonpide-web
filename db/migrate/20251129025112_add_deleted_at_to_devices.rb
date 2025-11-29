class AddDeletedAtToDevices < ActiveRecord::Migration[8.1]
  def change
    add_column :devices, :deleted_at, :datetime
  end
end
