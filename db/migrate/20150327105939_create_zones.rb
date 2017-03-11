class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.float :lat_min
      t.float :lat_max
      t.float :lng_min
      t.float :lng_max
      t.attachment :image
    end
  end
end
