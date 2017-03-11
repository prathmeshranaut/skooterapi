class CreateUserFollowingCategories < ActiveRecord::Migration
  def change
    create_table :user_following_categories do |t|
      t.belongs_to :user, index: true
      t.belongs_to :zone, index: true
      t.belongs_to :category, index: true
    end
    add_foreign_key :user_following_categories, :users
    add_foreign_key :user_following_categories, :zones
    add_foreign_key :user_following_categories, :categories
  end
end
