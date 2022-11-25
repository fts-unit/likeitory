class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    flash[:pageinfo] = "つぶやき一覧"
    @followings_count = Follow.where(follower_id: @current_user.id).where.not(following_id: @current_user.id).count
    @post = Post.new
    if @followings_count == 0
      @posts = Post.all
    else
      follows = Follow.where(follower_id: @current_user.id)
      followings = []
      follows.each do |follow|
        followings.push(follow.following_id)
      end
      @posts = Post.where('user_id IN (?)', followings).order(created_at: :desc)
    end
  end

  def all
    flash[:pageinfo] = "つぶやき一覧"
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Likestory.where(post_id: @post.id, f_del: false).count
    flash[:pageinfo] = @post.content
  end
  
  def new
    flash[:pageinfo] = "新規投稿"
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
    )
    if @post.save
      flash[:notice] = "つぶやきを作成しました"
      redirect_to('/posts/index')
    else
      render("posts/new")
    end
  end

  def edit
    flash[:pageinfo] = "つぶやき編集"
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "つぶやきを編集しました"
      redirect_to('/posts/index')
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "つぶやきを削除しました"
    redirect_to('/posts/index')
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
