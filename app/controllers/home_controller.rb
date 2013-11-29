class HomeController < ApplicationController

  skip_before_filter :require_login

  def index
    @products = Product.limit(5)
    @blogs = Blog.limit(2)
    @users = User.limit(3)
  end
  
  def login
    user = User.where(name: params[:name], password: params[:password]).first
    set_current_user(user) and redirect_to root_path if user.present?
  end
  
  def logout
    session[:uid] = nil
    @current_user = nil
    redirect_to root_path
  end
end
