class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    flash[:notice] = "Welcome! You have signed up successfully."
    redirect_to book_path(@book.id)
  end
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to books_path
    end
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @books = @user.books
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
   def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
   end
  
end
