class Users::OmniauthCallbacksController < ApplicationController
  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    provider = provider.to_s

    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    @user.skip_confirmation!

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
