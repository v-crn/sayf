# frozen_string_literal: true

module UsersHelper
	def icon_for(user, size: 80)
		if Rails.env.production?
			icon = user.icon_url.blank? ? "user.png" : user.icon_url
		else
			if user.icon_identifier.blank?
				icon = "user.png"
			elsif user.icon_identifier.start_with?("http")
				icon = user.icon_identifier
			else
				icon = user.icon_url
			end		
		end
		image_tag(icon, alt: user.name, size: size, class: 'icon_image')
  end
end
