class PicturesController < ApplicationController

def create
	Instagram.configure do |config|
		config.client_id = Rails.application.secrets.instagram_client_id
		config.client_secret = Rails.application.secrets.instagram_client_secret
	end

	# Pry.start(binding)
	client = Instagram.client 
	# client.media_popular
	# client.tag_search('')
	@user_input = client.tag_recent_media('highway')[0].images.standard_resolution.url 
	# Pry.start(binding)


	respond_to do |format|
	format.json {render json: @user_input }
	end

end	





	# def instagram
	# 	Instagram.configure do |config|
	# 		config.client_id = Rails.application.secrets.instagram_client_id
	# 		config.client_secret = Rails.application.secrets.instagram_client_secret
	# 	end
	# end

end
