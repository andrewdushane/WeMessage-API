class AccountsController < ApplicationController
  before_action :set_account, only: [:show]

  # GET /accounts/search/:query
  def search_accounts
    @accounts = Account.select('id', 'name', 'email').where("lower(email) like ?", "%" + params[:query].downcase + "%")
    render json: @accounts
  end


  # GET /contacts
  def account_contacts
    authenticate_request!
    @contacts = @current_account.contacts
    render json: @contacts
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    authenticate_request!
    if @account
      render json: {
        name: @account.name,
        email: @account.email,
        image: @account.image
      }
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # GET /my-account
  def my_account
    authenticate_request!
    if @current_account
      render json: @current_account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /my-account
  def update
    authenticate_request!
    if @current_account.update(account_params)
      head :no_content
    else
      render json: @current_account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    authenticate_request!
    @current_account.destroy
    head :no_content
  end

  private

    def set_account
      if @account = Account.find(params[:id])
        return @account
      else
        render json: @account.errors, status: :unprocessable_entity
      end
    end

    def account_params
      params.permit(:email, :password, :name, :image)
    end
end
