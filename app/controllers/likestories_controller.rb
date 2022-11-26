class LikestoriesController < ApplicationController
  
  before_action :authenticate_user
  
  def create
    liker_count = Liker.where(user_id: @current_user.id).order(updated_at: :asc).count
    if liker_count == 0
      @error_message = "ライカがもういないので、いいねできません。"
      @post = Post.find_by(id: params[:post_id])
      @user = @post.user
      @likes_count = Likestory.where(post_id: @post.id, f_del: false).count
      flash[:pageinfo] = @post.content
      render("/posts/show")
    else
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
  end

  def destroy
    @likestory = Likestory.find_by(user_id: @current_user.id, post_id: params[:post_id], f_del: false)
    @likestory.f_del = true
    @likestory.save
    redirect_to("/posts/#{params[:post_id]}")
  end
    
  end