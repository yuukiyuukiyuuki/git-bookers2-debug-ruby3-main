class BooksController < ApplicationController

  def show
    @books=Book.new
    @book = Book.find(params[:id])
    @user=@book.user
  end

  def index
    @books = Book.all
    @book=Book.new
    @user=current_user
    @book.user_id=@user.id
  end

  def create
    @user=current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
     @user=current_user
   if @book.user_id != current_user.id
    redirect_to books_path
   end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
