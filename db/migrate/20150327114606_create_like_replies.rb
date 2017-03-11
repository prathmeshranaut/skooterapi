class CreateLikeReplies < ActiveRecord::Migration
  def change
    create_table :like_replies do |t|
      t.belongs_to :user, index: true
      t.belongs_to :reply, index: true
    end
    add_foreign_key :like_replies, :users
    add_foreign_key :like_replies, :replies
  end
end
