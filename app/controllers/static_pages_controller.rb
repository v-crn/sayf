class StaticPagesController < ApplicationController
  include Pagy::Backend

  def home
    @pagy_new_sayings, @new_sayings = pagy(Saying.limit(100).order(:created_at), items: 30)

    if user_signed_in?
      @user = current_user
      @saying = current_user.sayings.build
      @pagy_feed, @feed_items = pagy(current_user.feed)
    end
  end

  def help; end

  def about; end

  def contact; end
end
