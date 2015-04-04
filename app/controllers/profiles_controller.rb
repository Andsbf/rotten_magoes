class ProfilesController < ApplicationController
  def edit
  end

  def show
    @user=User.find(params[:user_id])
  end
end
