class AddAnonymousToReply < ActiveRecord::Migration
  def change
    add_column :replies, :anonymous, :boolean
  end
end
