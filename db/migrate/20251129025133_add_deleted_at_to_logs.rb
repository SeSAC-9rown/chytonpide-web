class AddDeletedAtToLogs < ActiveRecord::Migration[8.1]
  def change
    add_column :logs, :deleted_at, :datetime
  end
end
