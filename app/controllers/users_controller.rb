class UsersController < ApplicationController
  # editとupdateの前に logged_in_user を実行しログインされていなければログインさせる
  before_action :logged_in_user, only: [:edit, :update]
  # 別のユーザープロフィールを編集しようとしたらリダイレクトする
  before_action :correct_user,   only: [:edit, :update]
  
  # GET /users/:id
  def show
    # ユーザーを検索してインスタンス変数に詰める
    # @付きのインスタンス変数はviewで参照出来るなる
    @user = User.find(params[:id])
  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  
  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # リダイレクトした直後のページで表示する
      flash[:success] = "Welcome to the Sample App!"
      # リダイレクトする
      # redirect_to user_url(@user) と同義
      redirect_to @user
    else
      render 'new'
    end
  end
  
  # GET /users/:id/edit
  # 編集画面にUserの情報を描画する
  def edit
    @user = User.find(params[:id])
  end
  
  # PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    # :user属性を必須、名前、メールアドレス、パスワード、パスワードの確認属性を許可
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
