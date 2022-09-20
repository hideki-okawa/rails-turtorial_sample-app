require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

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
end
