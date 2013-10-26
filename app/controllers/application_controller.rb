class ApplicationController < ActionController::Base
  include ApplicationHelper
  
  protect_from_forgery
  
  #check_authorization :unless => :devise_controller?
  
  def has_role?(current_user, role)
    return !!current_user.roles.find_by_name(role.to_s.camelize)
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
