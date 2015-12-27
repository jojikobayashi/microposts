class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update] 
  
  def show
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    unless current_user != @user
     redirect_to root_path
    end
  end

  def update
    unless current_user != @user
     redirect_to root_path
    end
    if @user.update(user_params)
      redirect_to root_path , notice: '変更を保存しました'
    else
      render 'edit'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
