class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]


  # GET /accounts/:id/contacts
  def account_contacts
    authenticate_request!
    @account = Account.find(params[:id])
    @contacts = @account.contacts
    render json: @contacts
  end

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    if @account
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])

    if @account.update(account_params)
      head :no_content
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy

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
