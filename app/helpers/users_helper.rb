# frozen_string_literal: true

module UsersHelper
	def icon_for(user, size: 80)
		icon = if user.blank? || user.icon_identifier.blank?
						 "user.png"
					 elsif !Rails.env.production? && user.icon_identifier.start_with?("http")
						 user.icon_identifier
					 else
						 user.icon_url
					 end
		name = (user.blank? || user.name.blank?) ? "no user" : user.name
		image_tag(icon, alt: name, size: size, class: 'icon_image')
  end
end
