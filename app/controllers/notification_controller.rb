class NotificationController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	# access token and hashed_id is required with every request
	before_filter :restrict_access

	def notifications_load
		user_id = current_user.id
		notifications_unread = Notification.where(:user_id => user_id, :read => false).order('updated_at DESC').select(:id, :user_id, :post_id, :type_id, :counter, :read).limit(10)
		if notifications_unread.count < 10
			limit_required = 10 - notifications_unread.count
			notifications_read =  Notification.where(:user_id => user_id, :read => true).order('updated_at DESC').select(:id, :user_id, :post_id, :type_id, :counter, :read).limit(limit_required)
		end
		@json = []
		notifications_read.each_with_index do |notification|
			@json << notification_render(notification)
		end
		notifications_unread.each_with_index do |notification|
			@json << notification_render(notification)
		end
		render json: @json, status: :ok
	end

	def notifications_read
		if params[:notification_id].present?
			last_notif_time = Notification.find_by_id(params[:notification_id].to_i).updated_at
			read_notifs =  Notification.where(:user_id => current_user.id).where('updated_at <= ?', last_notif_time).limit(10)
			if read_notifs.update_all(:read => true)
				render json: {response: "Done"}, status: :ok
			else
				render json: {response: "Error"}, status: 501
			end
		else
			render json: {response: "Error"}, status: 501
		end
	end

	private

	def notification_render(notif)
		notification_data = {}
		notification_data[:redirect] = {}
		notification_data[:notification] = {}
		notification_data[:highlight] = {}
		case type_id
		when 1
			skoot = Skoot.find_by_id(notif.skoot_id)
			notification_data[:notification][:head] = "Reply"
			if counter == 1
				notification_data[:notification][:text] =  "Someone replied to your skoot \"" + skoot.content[0..20] + "...\""
			else
				notification_data[:notification][:text] = notif.counter.to_s + " replies on your skoot \"" + skoot.content[0..20] + "...\""
			end
			notification_data[:redirect][:check] = true
			notification_data[:redirect][:skoot_id] = notif.skoot_id
			notification_data[:highlight][:check] = true
			notification_data[:highlight][:reply_id] = notif.reply_id
		when 2
			skoot = Skoot.find_by_id(notif.skoot_id)
			reply = Reply.find_by_id(notif.reply_id)
			notification_data[:notification][:head] = "Reply on reply"
			if counter == 1
				notification_data[:notification][:text] =  "Someone replied on your replied skoot \"" + reply.content[0..20] + "...\""
			else
				notification_data[:notification][:text] = notif.counter.to_s + " replies on your replied skoot \"" + reply.content[0..20] + "...\""
			end
			notification_data[:redirect][:check] = true
			notification_data[:redirect][:skoot_id] = notif.skoot_id
			notification_data[:highlight][:check] = true
			notification_data[:highlight][:reply_id] = notif.reply_id
		when 3
			skoot = Skoot.find_by_id(notif.skoot_id)
			notification_data[:notification][:head] = "Likes on Skoot"
			notification_data[:notification][:text] = notif.counter.to_s + " likes on your skoot \"" + skoot.content[0..20] + "...\""
			notification_data[:redirect][:check] = true
			notification_data[:redirect][:skoot_id] = notif.skoot_id
			notification_data[:highlight][:check] = false
			notification_data[:highlight][:reply_id] = nil
		when 4
			skoot = Skoot.find_by_id(notif.skoot_id)
			reply = Reply.find_by_id(notif.reply_id)
			notification_data[:notification][:head] = "Likes on reply"
			notification_data[:notification][:text] = notif.counter.to_s + " likes on your reply \"" + reply.content[0..20] + "...\""
			notification_data[:redirect][:check] = true
			notification_data[:redirect][:skoot_id] = notif.skoot_id
			notification_data[:highlight][:check] = true
			notification_data[:highlight][:reply_id] = notif.reply_id
		else
			"There was some error in generating the notification!"
		end
		notification_data[:notification][:read] = notif.read
		notification_data[:skoot] = skoots_data([skoot], user_id)[0]
		notification_data[:id] = notif.id
		notification_data[:icon_url] = "https://s3-ap-southeast-1.amazonaws.com/skooterimages/notifications/" + type_id.to_s + ".png"
		return notification_data
	end
end
