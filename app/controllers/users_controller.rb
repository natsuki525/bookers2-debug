class UsersController < ApplicationController
  before_action :authenticate_user!
	before_action :baria_user, only: [:update]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
    @book = Book.find(params[:id]) #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    # 以下チャット機能のため追加
    @currentUserUserRoom = UserRoom.where(user_id: current_user.id)
    @userUserRoom = UserRoom.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserUserRoom.each do |cu|
        @userUserRoom.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      unless @isRoom
        @room = Room.new
        @user_room = UserRoom.new
      end
    end
  end

  def index
    @user = current_user
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）

  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user), notice: "successfully updated user!"
  	else
  		render :edit
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end

end
