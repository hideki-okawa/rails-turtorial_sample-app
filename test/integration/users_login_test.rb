require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  # ログインが成功することを確認する
  test "login with valid information" do
    # ログイン用のパスを開く
    get login_path
    # ログインする
    post login_path, params: { session: { email: @user.email, password: 'password' }}
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