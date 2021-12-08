class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @currentUserToRoom = Message.where(user_id: current_user.id)
    @userToRoom = Message.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserToRoom.each do |cu|
      @userToRoom.each do |u|
        if cu.room_id == u.room_id then
          @isRoom = true
          @roomId = cu.room_id
        end
        
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
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
