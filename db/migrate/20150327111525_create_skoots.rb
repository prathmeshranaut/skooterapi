class CreateSkoots < ActiveRecord::Migration
  def change
    create_table :skoots do |t|
      t.belongs_to :user, index: true
      t.text :content
      t.belongs_to :category, index: true
      t.belongs_to :location, index: true
      t.boolean :deleted_moderator, :default => false
      t.boolean :deleted_user, :default => false
      t.boolean :deleted_auto, :default => false

      t.timestamps null: false
    end
    add_foreign_key :skoots, :users
    add_foreign_key :skoots, :categories
    add_foreign_key :skoots, :locations
  end
end
