class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update]

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    render json: @contact
  end

  # POST /contacts
  # POST /contacts.json
  def create
    authenticate_request!
    if @current_account.id == params[:adder_id].to_i || @current_account.id == params[:added_id]
      @contact = Contact.new(contact_params)
      if @contact.save
        @added = Account.select('id','name','email').find(params[:added_id].to_i)
        render json: @added, status: :created, location: @contact
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    else
      render status: :unauthorized
    end
  end

  # DELETE /contacts/:id
  # :id is of account for contact to be deleted
  def destroy
    authenticate_request!
    if @current_account
      deleter = @current_account.id
      deleted = params[:id]
      @to_delete = Contact.where("adder_id = :deleter and added_id = :deleted", { deleter: deleter, deleted: deleted })
      if @to_delete
        @to_delete.destroy_all
        head :no_content
      end
    else
      render status: :unauthorized
    end
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
