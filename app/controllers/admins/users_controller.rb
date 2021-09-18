class Admins::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_user_path(@user)
      flash[:notice_update] = "会員情報を更新しました！"
    else
      edit_admins_user_path(@user)
    end
  end

  private

   def user_params
     params.require(:user).permit(:id, :profile_image_id, :name, :gender,
         :age, :introduction, :user_status)
   end

end
