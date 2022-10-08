class UsersController < ApplicationController
  # editとupdateの前に logged_in_user を実行しログインされていなければログインさせる
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # 別のユーザープロフィールを編集しようとしたらリダイレクトする
  before_action :correct_user,   only: [:edit, :update]
  # destoryの前に管理者家の確認を行う
  before_action :admin_user,     only: :destroy
    
  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # GET /users/:id
  def show
    # ユーザーを検索してインスタンス変数に詰める
    # @付きのインスタンス変数はviewで参照出来るなる
    @user = User.find(params[:id])
    # paginateメソッド→マイクロソフトの関連付けを経由してmicropostsテーブルから必要な情報を取得してくれる
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  
  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      # 確認メールの送信
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
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

  # DELETE /user/:id  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private

    # :user属性を必須、名前、メールアドレス、パスワード、パスワードの確認属性を許可
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # ログイン済みユーザーかどうか確認し、ログインをしていない場合はログイン画面にリダイレクトさせる
    def logged_in_user
      unless logged_in?
        # アクセスしようとしたページを保持する
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
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
