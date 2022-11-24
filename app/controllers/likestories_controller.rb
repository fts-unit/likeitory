class LikestoriesController < ApplicationController
  
  before_action :authenticate_user
  
  def create
    @liker = Liker.where(user_id: @current_user.id).order(updated_at: :asc).first
    @likestory = Likestory.new(
      user_id: @current_user.id,
      post_id: params[:post_id],
      liker_id: @liker.id
    )
    @likestory.save
    @post = Post.find_by(id: @likestory.post_id)
    @liker.user_id = @post.user_id
    @liker.save
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    @likestory = Likestory.find_by(user_id: @current_user.id, post_id: params[:post_id], f_del: false)
    @likestory.f_del = true
    @likestory.save
    redirect_to("/posts/#{params[:post_id]}")
  end
    
  end