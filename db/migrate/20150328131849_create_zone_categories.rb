class CreateZoneCategories < ActiveRecord::Migration
  def change
    create_table :zone_categories, :id => false do |t|
      t.belongs_to :zone, index: true
      t.belongs_to :category, index: true
    end
    add_foreign_key :zone_categories, :zones
    add_foreign_key :zone_categories, :categories
  end
end
