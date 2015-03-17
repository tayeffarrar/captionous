class CaptionsController < ApplicationController
	def configure_twitter
		client = Twitter::REST::Client.new do |config|
			config.consumer_key = "pu4D6ohzf9yG8XlM9hpJFAGWr"
			config.consumer_secret = "LNIimgn64o4jWpCgW3yNMLDoctjq4P8JvGU6L0sc33UuiRh6eZ"
			config.access_token = "43109004-OW0dzDk1SyzW07VmLlUhyAcPfi9IhhdOfReerUA8s"
			config.access_token_secret = "B7fQOSnL5R765OxWlOmYAlGN4p3uZcNaOiWokHyey7YLX"
		end
		@twitter_client = client
	end

	def fetch_results
		@captions_array = []
		@data_array = []
		@results.each do |result|
			@pictures_array << Caption.create!(
				:text => result.images.standard_resolution.url, 
				:contributor => result.user[:username]
			)
		end

		@pictures_array.map do |pic|
			@data_array << {url: pic.url}
		end
	end

	def create
		self.configure_twitter

		hashtag = "#"
		@results = @client.search("#{hashtag}#{params[:keyword]}")
		self.fetch_results
		
		respond_to do |format|
			format.json {render json: @data_array}
		end
	end

end
