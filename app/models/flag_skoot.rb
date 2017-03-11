class FlagSkoot < ActiveRecord::Base
	belongs_to :skoot
	belongs_to :user
	belongs_to :flag

	after_save :auto_delete_if_2

	def auto_delete_if_2
		if self.skoot.flag_skoots.pluck(:user_id).uniq.count >= 2
			self.skoot.update(:deleted_auto => true)
		end
	end
end
