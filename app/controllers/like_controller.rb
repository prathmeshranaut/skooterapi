class LikeController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	# access token and hashed_id is required with every request
	before_filter :restrict_access

	def like_skoot
		skoot_id = params[:skoot_id].to_i
		user_id = current_user.id
		like = LikeSkoot.find_or_create_by(:skoot_id => skoot_id, :user_id => user_id) 
		if like.save
			count = LikeSkoot.where(:skoot_id => skoot_id).pluck(:user_id).uniq.count
			render json: {response: "Done", count: count }, status: :ok
		else
			render json: {response: "Error"}, status: 501
		end
	end

	def like_reply
		reply_id = params[:reply_id].to_i
		user_id = current_user.id
		like = LikeReply.find_or_create_by(:reply_id => reply_id, :user_id => user_id) 
		if like.save
			count = LikeReply.where(:reply_id => reply_id).pluck(:user_id).uniq.count
			render json: {response: "Done", count: count }, status: :ok
		else
			render json: {response: "Error"}, status: 501
		end
	end

	def unlike_skoot
		skoot_id = params[:skoot_id].to_i
		user_id = current_user.id
		like = LikeSkoot.find_by(:skoot_id => skoot_id, :user_id => user_id) 
		if like.delete
			count = LikeSkoot.where(:skoot_id => skoot_id).pluck(:user_id).uniq.count
			render json: {response: "Unliked", count: count }, status: :ok
		else
			render json: {response: "Error"}, status: 501
		end
	end

	def unlike_reply
		reply_id = params[:reply_id].to_i
		user_id = current_user.id
		like = LikeReply.find_by(:reply_id => reply_id, :user_id => user_id) 
		if like.delete
			count = LikeReply.where(:reply_id => reply_id).pluck(:user_id).uniq.count
			render json: {response: "Unliked", count: count }, status: :ok
		else
			render json: {response: "Error"}, status: 501
		end
	end

end
