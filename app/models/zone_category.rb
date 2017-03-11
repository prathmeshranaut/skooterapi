class ZoneCategory < ActiveRecord::Base
	belongs_to :zone
	belongs_to :category

	validates_presence_of :zone_id, :category_id
end
