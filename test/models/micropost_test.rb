require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    # buildはnewと似たもの
    # ただしデータベースには反映しない
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  # マイクロソフトが有効
  test "should be valid" do
    assert @micropost.valid?
  end

  # ユーザーIDがnilなのでマイクロポストが無効
  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  
  # コンテンツが空なのでマイクロポストが無効
  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  # 文字数が140文字を超えているのでマイクロポストが無効
  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end
  
  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end