class UsersController < ApplicationController
  def index
    @user = User.includes(:followers, :followees, :tweets).all
    @tweets = Tweet.includes(:user).all
    @tweet = Tweet.new
  end

  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    update_count
    redirect_back(fallback_location: user_path(@user))
    flash[:notice] = "You are following #{@user.email} successfully"
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    update_count
    redirect_back(fallback_location: user_path(@user))
    flash[:alert] = "You are not following #{@user.email}"
  end

  private
  def update_count
    current_user.update_follower_counts
    @user.update_follower_counts
  end
end
