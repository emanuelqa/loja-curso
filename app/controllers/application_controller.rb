class ApplicationController < ActionController::Base

  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

protected

def layout_by_resource
  if devise_controller? && resource_name == :admin
    "backoffice_devise"
  else
    "application"
  end
 end

 def user_not_authorized
    flash[:alert] = "Você não está autorizado a realizar essa ação."
    redirect_to(request.referrer || root_path)
  end

end
