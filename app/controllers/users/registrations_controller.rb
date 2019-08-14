# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, if: :devise_controller?

	def profile_edit
		current_user.icon.cache! unless current_user.icon.blank?
  end

  def profile_update
		current_user.assign_attributes(account_update_params)
    if current_user.save
	  	redirect_to user_path(id: current_user.id), notice: 'Updated profile'
    else
      render "profile_edit", notice: 'Update error'
    end
  end

	protected

	def configure_account_update_params
		devise_parameter_sanitizer.permit(:account_update, 
			keys: [:name, :icon, :icon_cache, :remove_icon, :profile])
	end
end
