class CreateUserAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :user_accounts do |t|
      t.timestamps
    end
  end
end
