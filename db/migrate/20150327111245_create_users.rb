class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :device
      t.string :access_token
      t.string :name
      t.string :email
      t.string :registration_id
      t.boolean :notify, :default => true
      t.boolean :deleted_moderator, :default => false
      t.boolean :deleted_auto, :default => false

      t.timestamps null: false
    end
  end
end
