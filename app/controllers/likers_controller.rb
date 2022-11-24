class LikersController < ApplicationController
  
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def show
    @liker = Liker.find_by(id: params[:id])
    if @liker.name
      flash[:pageinfo] = @liker.name
    else
      flash[:pageinfo] = Settings.liker.unnamed_liker_name
    end
    @likestories = Likestory.where(liker_id: @liker.id).order(created_at: :desc)
  end

  def edit
    flash[:pageinfo] = "ライカに命名"
    @liker = Liker.find_by(id: params[:id])
  end

  def update
    @liker = Liker.find_by(id: params[:id])
    if params[:name] == "" 
      @liker.errors.add(:name, 'を入力してください')
      render("likers/edit")
    else
      @liker.name = params[:name]
      @liker.namer_id = @current_user.id
      if @liker.save
        flash[:notice] = "ライカに命名しました"
        redirect_to("/likers/#{@liker.id}")
      else
        @liker.errors.add(:base, '他のなまえを入力してください')
        render("likers/edit")
      end
    end
  end

  def ensure_correct_user
    @liker = Liker.find_by(id: params[:id])
    if (@current_user.id != @liker.user_id || @liker.name != nil) && @current_user.id != @liker.namer_id
      flash[:notice] = "権限がありません"
      redirect_to("/likers/#{params[:id]}")
    end
  end
end