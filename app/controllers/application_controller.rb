class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action  :store_location

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name icon])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name icon profile])
  end

  def store_location
    if request.fullpath != new_user_registration_path &&
       request.fullpath != new_user_session_path &&
       request.fullpath !~ Regexp.new('\\A/users/password.*\\z') &&
       !request.xhr? # don't store ajax calls
      session[:previous_url] = request.fullpath
     end
   end

  def after_sign_in_path_for(resource)
    if session[:previous_url] == root_path
      super
    else
      session[:previous_url] || root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if session[:previous_url] == root_path
      super
    else
      session[:previous_url] || root_path
    end
  end
end
