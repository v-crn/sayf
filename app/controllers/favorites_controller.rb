class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  after_action :reload_with_ajax, only: %i[create destroy]

  def create
    @saying = Saying.find(create_favorite_params)
    current_user.like(@saying)
  end

  def destroy
    @favorite = Favorite.find(destroy_favorite_params)
    @saying = Saying.find(@favorite.saying_id)
    current_user.unlike(@saying)
  end

  private

  def create_favorite_params
    params.require(:saying_id)
  end

  def destroy_favorite_params
    params.require(:id)
  end

  def reload_with_ajax
    respond_to do |format|
      format.html { redirect_back(fallback_location: request.referer) }
      format.js
    end
  end
end
