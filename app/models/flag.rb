class Flag < ActiveRecord::Base
	has_many :flag_skoots
	has_many :flag_replies
end
