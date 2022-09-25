class UsersController < ApplicationController
  
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
end
