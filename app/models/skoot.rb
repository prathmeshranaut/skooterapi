class Skoot < ActiveRecord::Base
	belongs_to :user
	belongs_to :location
	belongs_to :category

	has_many :replies
	has_many :like_skoots
	has_many :flag_skoots
	has_many :notifications
	has_many :skoot_images

	validates_presence_of :user_id, :content, :location_id, :category_id
	validates :content, length: { maximum: 200}
end
