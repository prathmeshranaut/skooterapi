class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.string :name
    end
  end
end
