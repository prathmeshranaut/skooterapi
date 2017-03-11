class UserFollowingCategory < ActiveRecord::Base
  belongs_to :user
  belongs_to :zone
  belongs_to :category
end
