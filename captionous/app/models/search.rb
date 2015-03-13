class Search < ActiveRecord::Base
	has_many :pictures

	before_create: fetch_results

	def fetch_results
		results = instagram.tag_recent_media(query)
		binding.pry
		results.each do |result|
			self.pictures << Picture.new {
				url: result.images.standard_resolution
			}
		end
	end

	private

	def instagram
		Instagram.configure do |config|
			config.client_id = Rails.application.secrets.instagram_client_id
			config.client_secret = Rails.application.secrets.instagram_client_secret
		end
	end
	
end
