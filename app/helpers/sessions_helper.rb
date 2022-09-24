module SessionsHelper
   # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 現在ログイン中のユーザーを返す（いる場合）
  # 一時cookiesに暗号化済みのユーザーIDが自動で作成される
  # ユーザーが存在しない場合はnilで返す
  def current_user
    p "start current_user"
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
end
