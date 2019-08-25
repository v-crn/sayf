class StaticPagesController < ApplicationController
  include Pagy::Backend

  def home
    if user_signed_in?
      @user = current_user
      @saying = current_user.sayings.new
      @pagy_feed, @feed_items = pagy(current_user.feed)
    else
      # New Posts
      @pagy_feed, @feed_items = pagy(Saying.limit(100).order(:created_at), items: 30)
    end
  end

  def about; end

  def contact; end

  def tos; end

  def privacy; end

  def new_sayings
    @user = current_user if user_signed_in?
    @pagy_feed, @feed_items = pagy(Saying.limit(100).order(:created_at), items: 30)
  end
end
