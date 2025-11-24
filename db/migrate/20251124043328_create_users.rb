class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :provider
      t.string :uid
      t.string :name
      t.string :avatar_url
      t.string :social_avatar_url

      t.timestamps
    end
  end
end
