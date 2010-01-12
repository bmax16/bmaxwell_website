class AdminController < ApplicationController
  def login
    if request.post?
      if User.count.zero?
        user = User.new(:name => params[:name], :password => params[:password],
                        :password_confirmation => params[:password])
        user.save
      else
        user = User.authenticate(params[:name], params[:password])
      end
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || root_url)
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end
end
