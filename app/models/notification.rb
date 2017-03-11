class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :skoot
  belongs_to :reply
end
