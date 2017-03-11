class ContentController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :authenticate_admin!

	def index
		if params[:zone_id].present?
			@zone = Zone.find_by_id(params[:zone_id].to_i)
		else
			@zone = Zone.first
		end
	end

	def zone
		if params[:id].present?
			zone = Zone.find_by_id(params[:id].to_i)
			zone.update(zone_params)
		else
			zone = Zone.new(zone_params)
		end
		if zone.save
			redirect_to admin_content_path, notice: 'Zone was successfully created.'
		else
			redirect_to admin_content_path, notice: 'Zone creation failed.'
		end
	end

	def categories
		category_id = params[:category_id].to_i
		zone_id = params[:zone_id].to_i
		zone_category = ZoneCategory.find_by(:category_id => category_id, :zone_id => zone_id)
		unless zone_category.present?
		 	zone_category = ZoneCategory.new(:category_id => category_id, :zone_id => zone_id)
		end
		if zone_category.save
			redirect_to admin_content_path, notice: 'Category was successfully addded.'
		else
			redirect_to admin_content_path, notice: 'Failed'
		end
	end

	def skoot
		category_id = params[:category_id]
		content = params[:content]
		image = params[:image]
		zone_id = params[:zone_id].to_i
		zone = Zone.find_by_id(zone_id)
		lat = rand * (zone.lat_max - zone.lat_max) + zone.lat_min
		lng = rand * (zone.lng_max - zone.lng_min) + zone.lng_min
		user_id = rand(5) + 1
		location = Location.create(:user_id => rand(5) + 1, :lat => lat, :long => lng) if zone_id != 1
		location = Location.find_by_id(user_id) if zone_id == 1
		skoot = Skoot.create(:location_id => location.id, :content => content, :category_id => category_id, :user_id => user_id)
		if image.present?
			SkootImage.create(:image => image, :skoot_id => skoot.id)
		end
		if skoot.save
			redirect_to admin_content_path, notice: 'Skoot was successfully created.'
		else
			redirect_to admin_content_path, notice: 'Failed'
		end
	end

	def notif
	end

	private

	def zone_params
		params.permit(:name, :lat_min, :lat_max, :lng_min, :lng_max)
	end

end
