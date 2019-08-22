class UsersController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!, only: %i[index
                                              following followers
                                              favorite_sayings]

  def index
    @pagy_users, @users = pagy(User.all, items: 30)
  end

  def show
    @user = User.find(params[:id])
    @pagy_sayings, @sayings = pagy(@user.sayings, items: 10)
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @pagy, @users = pagy(@user.following, items: 100)
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @pagy, @users = pagy(@user.followers, items: 100)
    render 'show_follow'
   end

  def favorite_sayings
    @user = User.find(params[:id])
    @pagy_fav, @favorite_sayings = pagy(@user.fav_sayings, items: 30)
  end
end
