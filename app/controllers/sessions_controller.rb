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
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
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
