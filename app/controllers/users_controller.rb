class UsersController < ApplicationController

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = current_user
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
      render 'new'
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
       flash[:success] = "You have updated user successfully."
      redirect_to books_path
    else
      render '/users/:id/edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
