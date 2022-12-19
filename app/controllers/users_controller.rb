class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def index
    flash[:pageinfo] = "ユーザー一覧"
    @users = User.all
  end

  def new
    flash[:pageinfo] = "新規登録"
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name], 
      email: params[:email],
      password: params[:password]
    )
    if params[:passward_confirm] == params[:password]
      if @user.save
        num = 0
        while num < 10 do
            liker = Liker.new(user_id: @user.id)
            liker.save
            num += 1
        end
        @follow = Follow.new(
          follower_id: @user.id,
          following_id: @user.id
        )
        @follow.save
        session[:user_id] = @user.id
        flash[:notice] = "ユーザー登録が完了しました"
        redirect_to("/users/#{@user.id}")
      else
        render("users/new")
      end
    else
      @user.errors.add(:base, 'パスワードが合致しません。入力し直してください。')
      render("users/new")
    end
end

  def edit
    flash[:pageinfo] = "ユーザー情報の編集"
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.intro = params[:intro]
    @user.image_name = params[:image_name]
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    # , password: params[:password]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
      redirect_to("/login")
  end

    
  def followers
    user = User.find_by(id: params[:id])
    flash[:pageinfo] = user.name << " のフォロワー"
    follows = Follow.where(following_id: params[:id]).where.not(follower_id: params[:id])
    followers = []
    follows.each do |follow|
        followers.push(follow.follower_id)
    end
    @users = User.where('id IN (?)', followers).order(created_at: :desc)
  end

  def followings
    user = User.find_by(id: params[:id])
    flash[:pageinfo] = user.name << " がフォロー中"
    follows = Follow.where(follower_id: params[:id]).where.not(following_id: params[:id])
    followings = []
    follows.each do |follow|
      followings.push(follow.following_id)
    end
    @users = User.where('id IN (?)', followings).order(created_at: :desc)
  end



  def show
    @path = "show"
    @user = User.find_by(id: params[:id])
    @followers_count = Follow.where(following_id: params[:id]).where.not(follower_id: params[:id]).count
    @followings_count = Follow.where(follower_id: params[:id]).where.not(following_id: params[:id]).count
    flash[:pageinfo] = @user.name
  end

  def likes
    @path = "likes"
    @user = User.find_by(id: params[:id])
    @likes = Likestory.where(user_id: @user.id, f_del: false)
    @followers_count = Follow.where(following_id: params[:id]).where.not(follower_id: params[:id]).count
    @followings_count = Follow.where(follower_id: params[:id]).where.not(following_id: params[:id]).count
    flash[:pageinfo] = @user.name
  end

  def likers
    @path = "likers"
    @user = User.find_by(id: params[:id])
    @likers = Liker.where(user_id: @user.id).order(updated_at: :desc)
    @followers_count = Follow.where(following_id: params[:id]).where.not(follower_id: params[:id]).count
    @followings_count = Follow.where(follower_id: params[:id]).where.not(following_id: params[:id]).count
    flash[:pageinfo] = @user.name
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/users/index")
    end
  end
  
  private 
  def user_params
    params.require(:user).permit(:name, :email, :intro, :image)
  end

end
