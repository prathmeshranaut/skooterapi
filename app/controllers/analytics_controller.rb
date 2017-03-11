class AnalyticsController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :authenticate_admin!
	before_action :authenticate_admin_type

	def skoot
	end

	def zone
	end

	def user
	end
end
