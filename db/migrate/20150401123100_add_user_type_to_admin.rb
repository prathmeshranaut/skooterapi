class AddUserTypeToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :user_type, :integer
  end
end
