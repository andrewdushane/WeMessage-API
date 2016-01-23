class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  def index
    @contacts = Contact.all

    render json: @contacts
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    render json: @contact
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy

    head :no_content
  end

  # GET /contacts/account/:accountid
  def account_contacts
    authenticate_request!
    @account = Account.find([params[:accountid]])
    @contacts = @account.contacts
    render json: @contacts
  end

  private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.permit(:adder_id, :added_id)
    end

end
