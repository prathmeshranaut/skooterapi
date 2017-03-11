class SkootController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	# access token and hashed_id is required with every request
	before_filter :restrict_access

	def create_skoot
		content = params[:content]
		user_id = current_user.id
		category_id = params[:category_id].to_i
		location_id = params[:location_id].to_i
		images = params[:images]
		anonymous = params[:anonymous]

		skoot = Skoot.find_by(:user_id => user_id, :content => content, :category_id => category_id, :location_id => location_id, :anonymous => anonymous)
		if skoot.present? and skoot.created_at > Time.now - 5.minutes
			render json: {response: "Already Created"}, status: 403
		else
			skoot = Skoot.new(:user_id => user_id, :content => content, :category_id => category_id, :location_id => location_id, :anonymous => anonymous)
			if images.present?
				if skoot.save
					unless images.is_a? Array
						img = Magick::Image.read(images.tempfile.path).first
						width = img.columns
						height = img.rows
						if height > width
							factor = height.to_f/300
						else
							factor = width.to_f/300
						end 
						height = height/factor
						width = width/factor
						SkootImage.create(:image => images, :skoot_id => skoot.id, :width => width.to_i, :height => height.to_i)
					else
						images.each do |image|
							img = Magick::Image.read(image.tempfile.path).first
							width = img.columns
							height = img.rows
							if height > width
								factor = height.to_f/300
							else
								factor = width.to_f/300
							end 
							height = height/factor
							width = width/factor
							SkootImage.create(:image => image, :skoot_id => skoot.id, :width => width.to_i, :height => height.to_i)
						end
					end
					@json = {}
					@json[:response] = "Done"
					@json[:skoot] = skoots_data([skoot], user_id)[0]
					render json: @json, status: :ok
					notify_area_skooters(skoot)
				else
					render json: {response: "Error"}, status: 501
				end
			else
				if skoot.save
					@json = {}
					@json[:response] = "Done"
					@json[:skoot] = skoots_data([skoot], user_id)[0]
					render json: @json, status: :ok
					notify_area_skooters(skoot)
				else
					render json: {response: "Error"}, status: 501
				end
			end
		end
	end

	def show_skoot
		skoot = Skoot.find_by_id(params[:skoot_id].to_i)
		user_id = current_user.id
		location_skoot = skoot.location
		location_user = current_location
		if user_id == skoot.user_id or (location_user.lat < location_skoot.lat + 0.03 and location_user.lat > location_skoot.lat - 0.03 and location_user.lng < location_skoot.lng + 0.03 and location_user.lng > location_skoot.lng - 0.03)
			allow_activity = true
		else
			allow_activity = false
		end
		@json = {}
		@json[:skoot] = skoots_data([skoot], user_id)[0]
		@json[:replies] = replies_data(skoot.replies.where(:deleted_moderator => false, :deleted_user => false, :deleted_auto => false), user_id)
		@json[:allow_activity] = allow_activity 
		render json: @json, status: :ok
	end

	def delete_skoot
		skoot = Skoot.find_by_id(params[:skoot_id].to_i)
		user_id = current_user.id
		if user_id = skoot.user_id
			skoot.update(:deleted_user => true)
			render json: {response: "Skoot deleted successfully"}, status: :ok
		else
			render json: {response: "Unauthorised"}, status: 401
		end
	end

	private

	def notify_area_skooters(skoot)
        lat = skoot.location.lat
        lng = skoot.location.lng
        location_ids = []
        locations_last = Location.
        						select([:user_id, 'MAX(created_at)', 'MAX(id) as id']).
        						group(:user_id)
        locations_last.each do |location|
        	location_ids << location.id
        end
        user_ids = Location.
        					where(:id => location_ids).
        					where('updated_at < ?', Time.now - 15.minutes).
        					where('lat > ? and lat < ? and lng > ? and lng < ?', lat - 0.03, lat + 0.03, lng - 0.03, lng + 0.03).pluck(:user_id).
        					uniq - [skoot.user_id]
        if user_ids.present?
			registration_ids = User.
									where(:id => user_ids, :notify => true).
									pluck(:registration_id)
			options = {data: {text: "Someone Skooted in your area!", head: "New Skoot"}}
		    $android_notification.send(registration_ids, options)
		end
	end
  
end
