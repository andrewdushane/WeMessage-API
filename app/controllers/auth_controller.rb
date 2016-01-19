require 'jwt'

class AuthController < ApplicationController

  def authenticate_for_jwt
    user = Account.find_by_credentials(params[:email], params[:password])
    if user
      render json: authentication_payload(user)
    else
      render json: { errors: ['Invalid username or password'] }, status: :unauthorized
    end
  end

  def test
    render json: { message: 'this route works'}
  end

  private

  def authentication_payload(user)
    return nil unless user && user.id
    {
      auth_token: AuthToken.encode({ user_id: user.id }),
      user: { id: user.id, email: user.email } # return whatever user info you need
    }
  end
end
