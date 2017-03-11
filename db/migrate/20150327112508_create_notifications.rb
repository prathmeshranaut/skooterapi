class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true
      t.integer :type_id
      t.boolean :read, :default => false
      t.integer :counter, :default => 1
      t.belongs_to :skoot, index: true
      t.belongs_to :reply, index: true

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :skoots
    add_foreign_key :notifications, :replies
  end
end
