# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "pages"

  before_filter :authorize, :except => :login

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

protected
  def authorize
    unless User.find_by_id(session[:user_id]) 
      session[:original_uri] = request.request_uri
      if User.count.zero?
        flash[:notice] = "Create a new admin account"
      else
        flash[:notice] = "Please log in"
      end
      redirect_to :controller => 'admin', :action => 'login'
    end
  end
end
