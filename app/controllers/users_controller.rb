class UsersController < ApplicationController
	include Pagy::Backend
	before_action :authenticate_user!, only: [:index, :edit, :update]
	
	def index
		@users = User.all
	end
	
	def show
		@user = User.find(params[:id])
		@pagy, @sayings = pagy(@user.sayings, items: 10)
  end
end
