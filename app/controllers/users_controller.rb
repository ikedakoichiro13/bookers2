class UsersController < ApplicationController

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    @user.save
    redirect_to books_path
 end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_path
    else
      render '/users/:id/edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
