class FlagReply < ActiveRecord::Base
	belongs_to :reply
	belongs_to :user
	belongs_to :flag

	after_save :auto_delete_if_2

	def auto_delete_if_2
		if self.reply.flag_replies.pluck(:user_id).count >= 2
			self.reply.update(:deleted_auto => true)
		end
	end
end
