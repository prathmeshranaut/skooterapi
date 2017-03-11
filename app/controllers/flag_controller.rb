class FlagController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	# access token and hashed_id is required with every request
	before_filter :restrict_access

	def flag_skoot
		user_id = current_user.id
		flag_name = params[:flag].downcase
		flag_id = Flag.where('LOWER(name) like ?', flag_name).first.id
		skoot_id = params[:skoot_id].to_i
		flag = FlagSkoot.new(:user_id => user_id, :skoot_id => skoot_id, :flag_id => flag_id)
		if flag.save
			render json: {response: "Done"}, status: :ok
		else
			render json: {response: "Error"}, status: 501
		end
	end

	def flag_reply
		user_id = current_user.id
		flag_name = params[:flag].downcase
		flag_id = Flag.where('LOWER(name) like ?', flag_name).first.id
		reply_id = params[:reply_id].to_i
		flag = FlagReply.new(:user_id => user_id, :reply_id => reply_id, :flag_id => flag_id)
		if flag.save
			render json: {response: "Done"}, status: :ok
		else
			render json: {response: "Error"}, status: 501
		end
	end
end
