class CreateSkootImages < ActiveRecord::Migration
  def change
    create_table :skoot_images do |t|
      t.attachment :image
      t.integer :height
      t.integer :width
      t.belongs_to :skoot, index: true

      t.timestamps null: false
    end
    add_foreign_key :skoot_images, :skoots
  end
end
