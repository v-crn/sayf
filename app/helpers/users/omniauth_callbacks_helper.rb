module Users::OmniauthCallbacksHelper
  def twitter_auth_url
    if Rails.env.production?
      user_twitter_omniauth_authorize_path
    else
      'http://127.0.0.1:3000/users/auth/twitter'
    end
  end
end
