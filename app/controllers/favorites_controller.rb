class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: %i[update]

  def update
    @favorite = Favorite.find(params[:id])
    @saying = Saying.find(@favorite.saying_id)
    return unless @favorite || @favorite.points || @saying

    if is_like_button?
      @favorite.update(points: @favorite.points + 1)
    else
      @favorite.update(points: @favorite.points - 1)
      @favorite.destroy! if @favorite.points <= 0
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: request.referer) }
      format.js
    end
  end

  private

  def is_like_button?
    params[:commit] == '+'
  end
end
