class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order, :current_user, :logged_in?
  def current_user
    @current_user || User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in"
      redirect_to root_path
    end
  end

  
  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
 


  
  
end
