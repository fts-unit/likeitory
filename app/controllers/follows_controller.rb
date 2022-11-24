class FollowsController < ApplicationController
  
    before_action :authenticate_user

    def create
        @follow = Follow.new(
            follower_id: @current_user.id,
            following_id: params[:user_id]
        )
        @follow.save
        redirect_to("/users/#{params[:user_id]}")
    end
  
    def destroy
        @follow = Follow.find_by(
            follower_id: @current_user.id,
            following_id: params[:user_id]
        )
        @follow.destroy
        redirect_to("/users/#{params[:user_id]}")
    end
      
    end