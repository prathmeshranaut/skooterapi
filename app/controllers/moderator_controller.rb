class ModeratorController < ApplicationController

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :authenticate_admin!

	def skoot
	end

	def reply
	end

	def autoremove_skoot
	end

	def autoremove_reply
	end
end
