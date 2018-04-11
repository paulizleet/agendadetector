class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #rescue_from ActionController::NoMethodError, with: :catch_all_errors
  rescue_from ActionController::RoutingError, with: :catch_all_errors
  rescue_from ActiveRecord::RecordNotFound, with: :catch_all_errors

  private

  def catch_all_errors
    redirect_to "/"
  end
end
