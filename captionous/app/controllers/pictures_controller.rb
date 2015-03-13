class PicturesController < ApplicationController

def show
	Instagram.configure do |config|
		config.client_id = Rails.application.secrets.instagram_client_id
		config.client_secret = Rails.application.secrets.instagram_client_secret
	end

	# Pry.start(binding)
	client = Instagram.client 
	# client.media_popular
	# client.tag_search('')
	testtag = client.tag_recent_media('highway')[0].images.standard_resolution.url 
	# Pry.start(binding)

end	

	# def instagram
	# 	Instagram.configure do |config|
	# 		config.client_id = Rails.application.secrets.instagram_client_id
	# 		config.client_secret = Rails.application.secrets.instagram_client_secret
	# 	end
	# end

end
