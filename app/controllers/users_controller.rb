class UsersController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
       flash[:success] = "Welcome! You have signed up successfully."
      redirect_to books_path
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    flash[:success] = "Signed out successfully."
    redirect_to root_path
  end

  def update
    @user = current_user
    if @user.update(user_params)
       flash[:success] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
