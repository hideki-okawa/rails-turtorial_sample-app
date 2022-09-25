require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  test "should get root" do
    # root_path にGETリクエストする
    get root_path
    # 200 のレスポンスが返ってくれば成功
    assert_response :success
    # titleタグに「Ruby on Rails Tutorial Sample App」と記述されていれば成功
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end
  
  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App"
  end
  
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end
end
