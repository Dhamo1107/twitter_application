class TweetsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user
  before_action :set_tweet, only: %i[show edit update destroy]

  def new
    @tweet = @user.tweets.new
  end

  def edit
    find_tweet
    authorize! :edit, @tweet
  end

  def create
    @tweet = @user.tweets.build(tweet_params)

    if @tweet.save
      redirect_to users_path, notice: "Tweet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    find_tweet
    authorize! :update, @tweet
    if @tweet.update(tweet_params)
      redirect_to users_path, notice: "Tweet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    find_tweet
    authorize! :destroy, @tweet
    @tweet.destroy
    redirect_to users_url, alert: "Tweet was successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_tweet
    @tweet = @user.tweets.find(params[:id])
  end

  def find_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
