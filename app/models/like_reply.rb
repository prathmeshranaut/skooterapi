class LikeReply < ActiveRecord::Base
	after_create :add_notification

	belongs_to :user
	belongs_to :reply

	validates_presence_of :user_id, :reply_id

	def add_notification
		like_count = self.reply.like_replies.count
		if !(like_count.to_s =~ /^5[0]*|1[0]+$/).nil?
			notification = Notification.find_by(:user_id => self.reply.user_id, :type_id => 4, :reply_id => self.reply_id, :skoot_id => self.reply.skoot_id)
			if notification.present?
				notification.update(:counter => like_count, :read => true)
			else
				Notification.create(:user_id => self.reply.user_id, :type_id => 4, :reply_id => self.reply_id, :counter => like_count, :skoot_id => self.reply.skoot_id)
			end
		end
	end
end
