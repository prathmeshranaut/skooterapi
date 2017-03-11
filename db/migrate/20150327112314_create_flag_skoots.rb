class CreateFlagSkoots < ActiveRecord::Migration
  def change
    create_table :flag_skoots do |t|
      t.belongs_to :skoot, index: true
      t.belongs_to :user, index: true
      t.belongs_to :flag, index: true
      t.boolean :seen, :default => false

      t.timestamps null: false
    end
    add_foreign_key :flag_skoots, :skoots
    add_foreign_key :flag_skoots, :users
    add_foreign_key :flag_skoots, :flags
  end
end
