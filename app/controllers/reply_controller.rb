class ReplyController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	# access token and hashed_id is required with every request
	before_filter :restrict_access

	def create_reply
		content = params[:content]
		skoot_id = params[:skoot_id].to_i
		user_id = current_user.id
		anonymous = params[:anonymous]

		reply = Reply.find_by(:user_id => user_id, :content => content, :skoot_id => skoot_id, :anonymous => anonymous)
		if reply.present? and reply.created_at > Time.now - 5.minutes
			render json: {response: "Already Created"}, status: 403
		else
			reply = Reply.new(:user_id => user_id, :content => content, :skoot_id => skoot_id, :anonymous => anonymous)
			if reply.save
				@json = {}
				@json[:response] = "Done"
				@json[:reply] = replies_data([reply], user_id)[0]
				render json: @json, status: :ok

				#notification to skoot owner
		        if reply.user_id != reply.skoot.user_id and reply.skoot.user.registration_id.present? and reply.skoot.user.notify == true
	       			registration_id = reply.skoot.user.registration_id 
	        		options = {data: {text: "Someone replied to your skoot!" , head: "Reply", skoot_id: reply.skoot_id}}
	        		$android_notification.send([registration_id], options)
		        end
		        #notification to other repliers
		        user_ids_notify = reply.skoot.replies.where(:deleted_moderator => false, :deleted_user => false, :deleted_auto => false).pluck(:user_id).uniq - [reply.user_id, reply.skoot.user_id]
			    if user_ids_notify.present?
			        registration_ids_replies = User.where(:id => user_ids_notify, :notify => true).pluck(:registration_id).uniq - [nil]
				    options = {data: {text: "Someone replied on your reply!" , head: "Reply on Reply", skoot_id: reply.skoot_id}}
			        $android_notification.send(registration_ids_replies, options)
			    end
			else
				render json: {response: "Error"}, status: 501
			end
		end
	end

	def delete_reply
		reply = Reply.find_by_id(params[:reply_id].to_i)
		user_id = current_user.id
		if user_id = reply.user_id
			reply.update(:deleted_user => true)
			render json: {response: "Reply deleted successfully"}, status: :ok
		else
			render json: {response: "Unauthorised"}, status: 401
		end
	end

end
