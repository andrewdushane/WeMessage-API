class StaticController < ApplicationController

  def index
    @message = {
      message: 'Welcome to the WeMessage API',
      source_code: 'https://github.com/andy-j-d/WeMessage-API'
    }
    render json: @message
  end

  def not_found
    @message = {
      message: 'Sorry, that endpoint was not found.'
    }
    render json: @message, :status => 404
  end

  def unacceptable
    @message = {
      message: 'Sorry, your request was denied.'
    }
    render json: @message, :status => 422
  end

  def internal_error
    @message = {
      message: 'Sorry, there was a server error. Try your request again later.'
    }
    render json: @message, :status => 500
  end

end
