class FeedController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	# access token and hashed_id is required with every request
	before_filter :restrict_access

	def latest
		location = current_location
		skoots = Skoot.joins(:location).
					where('lat > ? and lat < ? and lng > ? and lng < ?', location.lat - 0.03, location.lat + 0.03, location.lng - 0.03, location.lng + 0.03).
					where(:deleted_moderator => false, :deleted_user => false, :deleted_auto => false).
					order('created_at DESC').
					limit(100)

		render json: {skoots: skoots_data(skoots, current_user.id)}, status: :ok 
	end

	def category
		category_id = params[:category_id].to_i
		location = current_location
		skoots = Skoot.joins(:location).
					where(:category_id => category_id).
					where('lat > ? and lat < ? and lng > ? and lng < ?', location.lat - 0.03, location.lat + 0.03, location.lng - 0.03, location.lng + 0.03).
					where(:deleted_moderator => false, :deleted_user => false, :deleted_auto => false).
					order('created_at DESC').
					limit(100)

		render json: {skoots: skoots_data(skoots, current_user.id)}, status: :ok 
	end

	def hashtag
		hashtag = params[:hashtag].downcase
		location = current_location
		skoots = Skoot.joins(:location).
					where('LOWER(content) like ?', "% ##{hashtag}%").
					where('lat > ? and lat < ? and lng > ? and lng < ?', location.lat - 0.03, location.lat + 0.03, location.lng - 0.03, location.lng + 0.03).
					where(:deleted_moderator => false, :deleted_user => false, :deleted_auto => false).
					order('created_at DESC').
					limit(100)

		render json: {skoots: skoots_data(skoots, current_user.id), hashtag: params[:hashtag]}, status: :ok 
	end
  
end
