class AccountActivationsController < ApplicationController

  def edit
    # クエリ文字列で受け取ったemailでユーザーを検索
    user = User.find_by(email: params[:email])
    # ユーザーが存在する かつ 有効化されていない かつ 認証が通る場合
    # ユーザーを有効化する
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end