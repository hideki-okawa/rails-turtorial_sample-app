require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # root（home）ページの統合テスト
  test "layout links" do
    # rootパスにgetリクエスト
    get root_path
    # homeページが正しく表示されるか
    assert_template 'static_pages/home'
    # root_pathへのリンクが2つ存在するか
    assert_select "a[href=?]", root_path, count: 2
    # help_pathへのリンクが2つ存在するか
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
  end
end
