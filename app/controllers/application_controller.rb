class ApplicationController < ActionController::Base
	
	$android_notification = GCM.new("AIzaSyBxTxCJ9qa1pgAtJcdUvsHsCQnOEKX2GeY")

	private

	def skoots_data(skoots, user_id)
		skoots_data = []
		skoot_ids = []

		skoots.each do |skoot|
			skoot_ids << skoot.id
		end

		skoots.each_with_index do |skoot, index|
			skoots_data[index] = {}
			skoots_data[index][:content] = skoot.content
			skoots_data[index][:id] = skoot.id
			skoots_data[index][:created_at] = skoot.created_at

			skoots_data[index][:user] = {}
			if skoot.anonymous == false
				skoots_data[index][:user][:name] = skoot.user.name
				skoots_data[index][:user][:avatar_url] = "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png"
				skoots_data[index][:user][:id] = skoot.user.id
				skoots_data[index][:user][:anonymous] = false
			else
				skoots_data[index][:user][:name] = "Anonymous"
				skoots_data[index][:user][:avatar_url] = "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png"
				skoots_data[index][:user][:id] = nil
				skoots_data[index][:user][:anonymous] = true
			end

			skoots_data[index][:like] = {}
			skoots_data[index][:like][:count] = skoot.like_skoots.count
			skoots_data[index][:like][:user_liked] = skoot.like_skoots.find_by(:user_id => user_id).present?

			skoots_data[index][:reply] = {}
			skoots_data[index][:reply][:count] = skoot.replies.count
			unless skoot.skoot_images.present? 
				skoots_data[index][:images] = []
			else
				skoots_data[index][:images] = []
				skoot.skoot_images.each_with_index do |image, image_index|
					skoots_data[index][:images][image_index] = {}
					skoots_data[index][:images][image_index][:small] = {}
					skoots_data[index][:images][image_index][:small][:url] = image.image.url(:small)
					skoots_data[index][:images][image_index][:small][:height] = image.height
					skoots_data[index][:images][image_index][:small][:width] = image.width
					skoots_data[index][:images][image_index][:large] = {}
					skoots_data[index][:images][image_index][:large][:url] = image.image.url
				end
			end
		end
		return skoots_data
	end

	def replies_data(replies, user_id)
		replies_data = []
		reply_ids = []

		replies.each do |reply|
			reply_ids << reply.id
		end

		replies.each_with_index do |reply, index|
			replies_data[index] = {}
			replies_data[index][:id] = reply.id
			replies_data[index][:content] = reply.content
			replies_data[index][:created_at] = reply.created_at

			replies_data[index][:user] = {}
			if reply.anonymous == false
				replies_data[index][:user][:name] = reply.user.name
				replies_data[index][:user][:avatar_url] = "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png"
				replies_data[index][:user][:id] = reply.user.id
				replies_data[index][:user][:anonymous] = false
			else
				replies_data[index][:user][:name] = "Anonymous"
				replies_data[index][:user][:avatar_url] = "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png"
				replies_data[index][:user][:id] = nil
				replies_data[index][:user][:anonymous] = true
			end

			replies_data[index][:like] = {}
			replies_data[index][:like][:count] = reply.like_replies.count
			replies_data[index][:like][:user_liked] = reply.like_replies.find_by(:user_id => user_id).present?
		end
		return replies_data
	end

	def restrict_access
		unless access_token.present? or hashed_user_id.present?
			render json: {response: "Unauthorised"}, status: 401 
		else
			unless current_user.present?
				render json: {response: "Unauthorised"}, status: 401
			end
		end
	end

	def current_user
		User.find_by(:id => Hashids.new("3587e646ee5bc48e60fb7b29c7a43650961f33893846d8e06f83b528554518b352f563669db91e790ae781d2e9785baf2a2093acf2f6b7df434eebb72af6ce2f", 10).decode(hashed_user_id), :access_token => access_token)
	end

	def access_token
		request.headers["HTTP_ACCESS_TOKEN"]
	end

	def hashed_user_id
		request.headers["HTTP_USER_ID"]
	end

	def current_zone(location)
		zone = Zone.find_by('lat_min < ? and lat_max > ? and lng_min < ? and lng_max > ?', location.lat, location.lat, location.lng, location.lng)
		if zone.present?
			return {id: zone.id, name: zone.name}
		else
			return {id: 1, name: "Skooter"}
		end
	end

	def current_location
		Location.find_by_id(params[:location_id].to_i)
	end

	def authenticate_admin_type
		unless current_admin.user_type == 1
			redirect_to root_path
		end
	end

end
