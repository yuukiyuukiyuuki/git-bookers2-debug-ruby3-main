class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @user=current_user
  end

  def edit
    @user=User.find(params[:id])
    if @user.id != current_user.id
    redirect_to user_path(current_user.id)
    end
  end

  def create
    @user=User.new(user_params)
   if @user_log_in.save
    flash[:notice] ="Signed in successfully."
    redirect_to user_path(user.id)
   end
   if @user_sign_in.save
    flash[:notice] ="Welcome! You have signed up successfully."
    redirect_to user_path(user.id)
   end
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end