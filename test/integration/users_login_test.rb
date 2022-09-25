require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  # 有効なメール、無効なパスワードでログイン出来ないことを確認する
  test "login with valid email/invalid password" do
    # ログイン用のパスを開く
    get login_path
    # 新しいセッションのフォームが表示されたことを確認
    assert_template 'sessions/new'
    # 無効なパスワードを入力
    post login_path, params: { session: { email:    @user.email,
                                          password: "invalid" } }
    # ログイン出来ていないことを確認
    assert_not is_logged_in?
    # 新しいセッションのフォームが表示されたことを確認
    assert_template 'sessions/new'
    # エラーメッセージが表示されていることを確認する
    assert_not flash.empty?
    # ルートパスに戻る
    get root_path
    # エラーメッセージが消えていてることを確認する
    assert flash.empty?
  end

  # ログインが成功することを確認する
  test "login with valid information followed by logout" do
    # ログイン用のパスを開く
    get login_path
    # ログインする
    post login_path, params: { session: { email: @user.email, password: 'password' }}
    # ログイン出来ていることを確認
    assert is_logged_in?
    # リダイレクト先が正しいことを確認する
    assert_redirected_to @user
    # リダイレクト先に遷移する
    follow_redirect!
    # ユーザーページが表示されることを確認する
    assert_template 'users/show'
    # ログインページへのリンクが無いことを確認する
    assert_select "a[href=?]", login_path, count: 0
    # ログアウトページへのリンクがあることを確認する
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    
    # ログアウトする
    delete logout_path
    # ログイン状態でないことを確認する
    assert_not is_logged_in?
    # ルートページにリダイレクトされていることを確認
    assert_redirected_to root_url
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path
    # リダイレクトする
    follow_redirect!
    # ログインパスが存在することを確認する
    assert_select "a[href=?]", login_path
    # ログアウトパスが無いことを確認する
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  test "login with invalid information" do
    # ログイン用のパスを開く
    get login_path
    # 新しいセッションのフォームが表示されたことを確認
    assert_template 'sessions/new'
    # わざと無効なparamsハッシュを使ってセッション用パスにPOSTする
    post login_path, params: { session: { email: "", password: "" } }
    # セッションのフォームでフラッシュが表zされることを確認
    assert_template 'sessions/new'
    assert_not flash.empty?
    # 別のページでフラッシュが表示されないことを確認する
    get root_path
    assert flash.empty?
  end
end