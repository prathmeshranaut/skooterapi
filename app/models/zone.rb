class Zone < ActiveRecord::Base
	validates_presence_of :name, :lat_min, :lat_max, :lng_min, :lng_max
end
