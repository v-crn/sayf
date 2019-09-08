class SayingsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def search
    return if params[:keywords].blank?

    @keywords = params[:keywords]
    @pagy_results, @search_results = pagy(Saying.search_with(@keywords), items: 30)

    respond_to do |format|
      format.html { redirect_back(fallback_location: request.referer) }
      format.js
    end
  end

  def show
    @saying = Saying.find(params[:id])
    @referenced_saying_id = params[:id]
  end

  def create
    @saying = current_user.sayings.build(saying_params)
    if @saying.save
      flash[:success] = 'Saying created!'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @saying.destroy
    flash[:success] = 'Saying deleted'
    redirect_to root_url
  end

  private

  def saying_params
    params.require(:saying).permit(:content, :picture, :reference_id)
  end

  def correct_user
    @saying = current_user.sayings.find_by(id: params[:id])
    redirect_to root_url if @saying.nil?
  end
end
