class SayingsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	
	def create
		@saying = current_user.sayings.build(saying_params)
		if @saying.save
			flash[:success] = "Saying created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
  end

  def destroy
		@saying.destroy
		flash[:success] = "Saying deleted"
		redirect_to request.referrer || root_url
	end
	
	private
	
	def saying_params
		params.require(:saying).permit(:content, :picture)
	end
	
	def correct_user
		@saying = current_user.sayings.find_by(id: params[:id])
		redirect_to root_url if @saying.nil?
	end
end
