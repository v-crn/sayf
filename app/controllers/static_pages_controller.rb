class StaticPagesController < ApplicationController
	include Pagy::Backend
	
	def home
		if user_signed_in?
		@user = current_user
		@saying = current_user.sayings.build
		@pagy_feed, @feed_items = pagy(current_user.feed)
		end
  end

  def help
	end
	
	def about
		
	end
	
	def contact
		
	end
end
