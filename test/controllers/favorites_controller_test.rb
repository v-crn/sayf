require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    Warden.test_mode!
    @saying = sayings(:most_recent)
  end
end
