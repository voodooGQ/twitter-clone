module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user unless the
  # user has an image_path setting in the database.
  def profile_image_for(user, options = { size: 50 })
    if user.image_path
      url = asset_path(user.image_path)
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end
    image_tag(url, alt: user.username, class: "profile_image rounded")
  end
end
