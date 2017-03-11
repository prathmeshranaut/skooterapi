class LocationController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	# access token and hashed_id is required with every request
	before_filter :restrict_access

	def create_location
		user_id = current_user.id
		location = Location.where(:user_id => user_id).last
		lat = params[:lat].to_f
		lng = params[:lng].to_f
		if location.present? and location.lat.round(3) == lat.round(3) and location.lng.round(3) == lng.round(3)
			location.count += 1
		else
			location = Location.new(:lat => lat, :lng => lng, :user_id => user_id)
		end
		if location.save
			render json: {response: "Done", location_id: location.id, zone: {name: current_zone(location)[:name]}}, status: :ok
		else
	    	render json: {response: "Error"}, status: 501
		end
	end
  
end
