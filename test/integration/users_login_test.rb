require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

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