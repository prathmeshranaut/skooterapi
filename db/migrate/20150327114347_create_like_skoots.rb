class CreateLikeSkoots < ActiveRecord::Migration
  def change
    create_table :like_skoots do |t|
      t.belongs_to :user, index: true
      t.belongs_to :skoot, index: true
    end
    add_foreign_key :like_skoots, :users
    add_foreign_key :like_skoots, :skoots
  end
end
