class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.belongs_to :user, index: true
      t.text :content
      t.belongs_to :skoot, index: true
      t.boolean :deleted_user, :default => false
      t.boolean :deleted_moderator, :default => false
      t.boolean :deleted_auto, :default => false

      t.timestamps null: false
    end
    add_foreign_key :replies, :users
    add_foreign_key :replies, :skoots
  end
end
