module UsersHelper
  def icon_for(user, size: 80)
    icon = if user.blank? || user.icon.blank?
             'user.png'
           else
             user.icon_url
           end
    name = user.blank? || user.name.blank? ? 'no user' : user.name
    image_tag(icon, alt: name, size: size, class: 'icon_image')
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
   end
end
