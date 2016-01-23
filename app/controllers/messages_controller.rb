class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]
  # GET /messages
  # GET /messages.json
  def index
    authenticate_request!
    @messages = Message.all

    render json: @messages
  end

  # GET /messages/account/:id
  def account_messages
    @account = Account.find(params[:id])
    @messages = @account.sent_messages + @account.received_messages
    render json: @messages
  end

  # GET /messages/sender/:senderid/recipient/:recipientid
  def message_thread
    authenticate_request!
    @account = Account.find(params[:senderid])
    @messages = @account.sent_messages.where(recipient_account: params[:recipientid])
    @messages += @account.received_messages.where(sender_account: params[:recipientid])
    @messages.sort_by! { |message| message.created_at }
    render json: @messages
  end

  # GET /messages/sender/:senderid/recipient/:recipientid/latest
  # Use to render latest message on contact list
  def latest
    @account = Account.find(params[:senderid])
    @message = @account.sent_messages.where(recipient_account: params[:recipientid]).order(:created_at).last
    render json: @message
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    render json: @message
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    if @message.update(message_params)
      head :no_content
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy

    head :no_content
  end

  private

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.permit(:content, :delivered, :sender_account, :recipient_account)
    end
end
