require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  # テストが走る前に実行される
  def setup
    # @userはインスタンス変数、全てのテストで利用できる
    @user = User.new(name: "Example User", email: "usar@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  
  # @userは有効
  test "should be valid" do
    assert @user.valid?
  end
  
  # nameに無効な文字列が入っているので無効
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  # emailに無効な文字列が入っているので無効
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  # nameが有効文字数を超えているので無効
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  # emailが有効文字数を超えているので無効
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  # フォーマットが有効なメールドレスの検証
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
    
  # フォーマットが無効なメールアドレスの検証
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  # 重複により無効
  test "email addresses should be unique" do
    # 同じ属性のユーザーを複製
    duplicate_user = @user.dup
    # 元のユーザーを登録
    @user.save
    # 元のユーザーと複製したユーザーが重複しているため無効になる
    assert_not duplicate_user.valid?
  end
  
  # downcaseの動作確認
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Doo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  # passwordにスペースが含まれるので無効
  test "password should be present (nonblanck)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  # passowrdが最低文字列以下なので無効
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
