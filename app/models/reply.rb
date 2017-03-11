class Reply < ActiveRecord::Base
	after_create :notification_owner, :notification_other_users

	belongs_to :user
	belongs_to :skoot

	has_many :like_replies
	has_many :flag_replies
	has_many :notifications

	validates_presence_of :user_id, :content, :skoot_id
	validates :content, length: { maximum: 200}

	def notification_owner
		unless self.skoot.user_id == self.user_id
			notification = Notification.find_by(:user_id => self.skoot.user_id, :skoot_id => self.skoot_id, :type_id => 1)
			replies_count = self.skoot.replies.where(:deleted_moderator => false, :deleted_user => false, :deleted_auto => false).count
			if notification.present?
				notification.update(:counter => replies_count, :read => false, :reply_id => self.id)
			else
				Notification.create(:user_id => self.skoot.user_id, :skoot_id => self.skoot_id, :type_id => 1, :counter => replies_count, :reply_id => self.id)
			end
		end
	end

	def notification_other_users
		user_ids_no_notification = [self.user_id, self.skoot.user_id]
		user_ids_other_users = self.skoot.replies.where(:deleted_moderator => false, :deleted_user => false, :deleted_auto => false).where.not(:user_id => user_ids_no_notification).pluck(:user_id).uniq
		existing_notifs = Notification.where(:skoot_id => self.skoot_id, :type_id => 2)
		already_notified = existing_notifs.pluck(:user_id).uniq
		existing_notifs.update_all(:read => false, :reply_id => self.id)
		notify_user_ids = user_ids_other_users - already_notified
		notify_user_objects_array = []
		notify_user_ids.each do |user_id|
			notify_user_objects_array << {:user_id => user_id, :skoot_id => self.skoot_id, :type_id => 2, :reply_id => self.id}
		end
		Notification.create(notify_user_objects_array)
	end
end
