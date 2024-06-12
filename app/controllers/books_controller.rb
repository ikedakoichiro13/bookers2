class BooksController < ApplicationController

  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      flash.now[:alert] = @book.errors.full_messages.join(", ")
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "更新が成功しました。"
      redirect_to book_path(@book)
    else
      flash.now[:alert] = @book.errors.full_messages.join(", ")
      render :edit
    end
  end

  def index
     @books = Book.all
     @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def ensure_correct_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
