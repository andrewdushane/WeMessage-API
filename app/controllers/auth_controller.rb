require 'jwt'

class AuthController < ApplicationController

  def authenticate_for_jwt
    account = Account.find_by_credentials(params[:email], params[:password])
    if account
      render json: authentication_payload(account)
    else
      render json: { errors: ['Invalid username or password'] }, status: :unauthorized
    end
  end

  def create_with_jwt
    account = Account.new(account_params)
    if account.save
      render json: authentication_payload(account), status: :created
    else
      render json: account.errors, status: :unprocessable_entity
    end
  end

  private

  def authentication_payload(account)
    return nil unless account && account.id
    {
      auth_token: AuthToken.encode({ user_id: account.id }),
      account: { id: account.id, email: account.email, name: account.name }
    }
  end

  def account_params
    params.permit(:email, :password, :name, :image)
  end

end
