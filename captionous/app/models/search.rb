class Search < ActiveRecord::Base
	has_many :pictures

	before_create: fetch_results

	def fetch_results
		results = instagram.tag_recent_media(query)
		results.each do |result|
			self.picturess << Picture.new {
				url: result.images.standard_resolution
			}
		end
	end

	private

	def instagram
		Rails.config.instagram_client
	end
	
end
