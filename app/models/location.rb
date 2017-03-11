class Location < ActiveRecord::Base
	belongs_to :user
	has_many :skoots

	validates_presence_of :user_id, :lat, :lng
end
