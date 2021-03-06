require 'application_responder'

class ApplicationController < ActionController::Base
  after_action :verify_authorized unless :devise_controller?

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def user_not_authorized
    respond_with do |format|
      format.json { render nothing: true, status: :forbidden }
      format.js { render nothing: true, status: :forbidden }
      format.html do
        redirect_to( request.referrer || root_path )
        flash[:alert] = 'You are not authorized to perform this action.'
      end
    end
  end

  def model_name(object)
    object.model_name.human.downcase
  end
end
