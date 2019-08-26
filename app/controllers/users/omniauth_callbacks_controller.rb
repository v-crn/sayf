class Users::OmniauthCallbacksController < ApplicationController
  def twitter
    callback_from :twitter
  end

  def failure
    redirect_to new_user_registration_url
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'].except('extra'))

    if @user.persisted? # DBに保存済みかどうかを判定
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_session_url
    end
  end
end
