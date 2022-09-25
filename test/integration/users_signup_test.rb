require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  # サインアップに失敗することを確認
  test "invalid signup information" do
    # getメソッドでユーザー登録ページにアクセスする
    get signup_path
    # user_pathに対してpostメソッドでリクエストを送信する
    # assert_no_difference → 引数（User.count）が関数の実行前と後で変わらないことを確認する
    assert_no_difference 'User.count' do
      post users_path, params: { user: {name: "", email: "user@minvalid", password: "foo", password_confirmation: "bar"}}
    end
    assert_template 'users/new'
    # assert_select 'div#<CSS id for error explanation>'
    # assert_select 'div.<CSS class for field with error>''
  end
  
  # サインアップに成功することを確認
  test "valid signup information" do
    # getメソッドでユーザー登録ページにアクセスする
    get signup_path
    # assert_no_difference → 引数（User.count）が関数の実行前と後で変わることを確認する
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    # ログインされていることを確認する
    assert is_logged_in?
  end
end
