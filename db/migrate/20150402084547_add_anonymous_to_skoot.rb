class AddAnonymousToSkoot < ActiveRecord::Migration
  def change
    add_column :skoots, :anonymous, :boolean
  end
end
