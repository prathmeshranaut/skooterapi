class LikeSkoot < ActiveRecord::Base
	after_create :add_notification

	belongs_to :user
	belongs_to :skoot

	validates_presence_of :user_id, :skoot_id

	def add_notification
		like_count = self.skoot.like_skoots.count
		if !(like_count.to_s =~ /^5[0]*|1[0]+$/).nil?
			notification = Notification.find_by(:user_id => self.skoot.user_id, :type_id => 3, :skoot_id => self.skoot_id )
			if notification.present?
				notification.update(:counter => like_count, :read => true)
			else
				Notification.create(:user_id => self.skoot.user_id, :type_id => 3, :skoot_id => self.skoot_id, :counter => like_count)
			end
		end
	end
end
