class Admin::UsersController < ApplicationController

  before_filter :admin_access


  def index
    @users = User.order(:firstname).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{@user.firstname} was successfully created!"
    else
      render :new
    end
  end

  def update
    
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.bye_email(@user).deliver_later 
    @user.destroy
    redirect_to admin_users_path, alert: "#{@user.firstname} deleted successfully"
  end

  def view_mode
    session[:admin_id] =  current_user.id
    session[:user_id] = params[:id]
    redirect_to movies_path
  end

  def  exit_view_mode
     session[:user_id] = session[:admin_id]
     session[:admin_id] = nil
     redirect_to admin_users_path, notice: "View mode session finished!"
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end