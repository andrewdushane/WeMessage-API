class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]
  # GET /messages
  # GET /messages.json
  def index
    authenticate_request!
    @messages = Message.all

    render json: @messages
  end

  # GET /messages/sender/:senderid/recipient/:recipientid
  def message_thread
    @messages = get_message_thread(params)
    render json: @messages
  end

  # GET /messages/sender/:senderid/recipient/:recipientid/latest
  # Use to render latest message on contact list
  def latest
    @messages = get_message_thread(params)
    render json: @messages.last
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    authenticate_request!
    if @current_account.id == @message.sender_account || @message.recipient_account
      render json: @message
    else
      render status: :unauthorized
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    authenticate_request!
    if @current_account.id == params[:sender_account].to_i
      @message = Message.new(message_params)
      if @message.save
        render json: @message, status: :created, location: @message
      else
        render json: @message.errors, status: :unprocessable_entity
      end
    else
      render json: {
        message: 'You are not authorized to create this message.'
        }, :status => :unauthorized
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    authenticate_request!
    if @current_account.id == @message.sender_account || @message.recipient_account
      @message = Message.find(params[:id])
      if @message.update(message_params)
        head :no_content
      else
        render json: @message.errors, status: :unprocessable_entity
      end
    else
      render status: :unauthorized
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    authenticate_request!
    if @current_account.id == @message.sender_account || @message.recipient_account
      @message.destroy
      head :no_content
    else
      render status: :unauthorized
    end
  end

  private

    def get_message_thread(params)
      authenticate_request!
      @messages = @current_account.sent_messages.where(recipient_account: params[:recipientid])
      @messages += @current_account.received_messages.where(sender_account: params[:recipientid])
      return @messages.sort_by! { |message| message.created_at }
    end

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.permit(:content, :delivered, :sender_account, :recipient_account)
    end
end
