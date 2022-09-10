require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static_pages/home' # Homeページが正しく表示されるか
    assert_select "a[href=?]", root_path, count: 2 # root_pathへのリンクが2つ存在するか
    assert_select "a[href=?]", help_path # help_pathへのリンクが存在するか
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end
end
