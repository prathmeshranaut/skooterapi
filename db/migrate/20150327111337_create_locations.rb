class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.belongs_to :user, index: true
      t.float :lat
      t.float :lng
      t.integer :count, :default => 1

      t.timestamps null: false
    end
    add_foreign_key :locations, :users
  end
end
