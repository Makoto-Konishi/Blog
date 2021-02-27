class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id unless current_user
      redirect_to users_url(@user), notice:"ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
    
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :email, :password, :password_confirmation)
  end
end
