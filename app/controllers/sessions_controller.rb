class SessionsController < ApplicationController
  # GET /login
  def new
  end
  
  # POST /login ログイン機能
  def create
    # params[:session] にフォームに入力された情報が入っている
    # メールアドレスでユーザーを検索する
    user = User.find_by(email: params[:session][:email].downcase)
    # ユーザーがデータベースに存在する かつ 認証に成功した場合
    if user && user.authenticate(params[:session][:password])
      # ログインする
      log_in user
      # チェックボックスが付いていればユーザーのセッションを永続化
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # ログインユーザーのページにリダイレクトする
      redirect_to user
    else
      # エラーメッセージを表示する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  # DELETE /logout ログアウト機能
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
