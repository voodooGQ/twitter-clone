# frozen_string_literal: true

module AuthHelper
  def http_login(user)
    SessionsController.create(
      {
        email: user.email,
        password: user.password
      }
    )
  end
end
