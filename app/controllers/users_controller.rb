class UsersController < ApplicationController

  skip_before_filter :require_login
  before_filter :load_user, only: [:show, :update, :edit, :destroy]

  def index
    @users = User.paginate page: params[:page]||1, per_page: 10
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.logo = params[:user][:logo]
    if @user.save
      set_current_user(@user)
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    redirect_to users_path if @user.destroy
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :logo, :gender, :password_confirmation)
  end
end
