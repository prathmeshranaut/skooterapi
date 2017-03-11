class CreateFlagReplies < ActiveRecord::Migration
  def change
    create_table :flag_replies do |t|
      t.belongs_to :reply, index: true
      t.belongs_to :user, index: true
      t.belongs_to :flag, index: true
      t.boolean :seen, :default => false

      t.timestamps null: false
    end
    add_foreign_key :flag_replies, :replies
    add_foreign_key :flag_replies, :users
    add_foreign_key :flag_replies, :flags
  end
end
