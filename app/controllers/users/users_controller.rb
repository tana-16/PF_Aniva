class Users::UsersController < ApplicationController
  before_action :set_user, only: [:likes]
  def show
    @user = User.find(params[:id])
    @post = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def check
    @user = current_user
  end

  def out
    @user = current_user
    @user.update(user_status: true)
    reset_session
    redirect_to root_path
  end

  def likes
    @user = User.find(params[:id])
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :age, :gender)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
