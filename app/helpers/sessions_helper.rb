module SessionsHelper
   # 渡されたユーザーでログインする
  def log_in(user)
    # ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動生成される
    # セッションにユーザーIDを保存する
    session[:user_id] = user.id
  end
  
  # 現在ログイン中のユーザーを返す（いる場合）
  # ユーザーが存在しない場合はnilで返す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # ログアウトする
  def log_out
    # セッションからユーザーIDを削除する
    session.delete(:user_id)
    @current_user = nil
  end
end
