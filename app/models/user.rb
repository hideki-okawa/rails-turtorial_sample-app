class User < ApplicationRecord
  # メールアドレスを小文字に変換する
  before_save { self.email = email.downcase }
  # nameのバリデーション
  # presence: true → nameが存在していることをチェックする
  # length: { maximum: 50 } → 50文字まで
  validates :name, presence: true, length: { maximum: 50 }
  
  # emailのバリデーション
  # format: { with: VALID_EMAIL_REGEX } → メールフォーマットのチェック
  # uniqueness: { case_sensitive: false } → 重複チェック
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  # セキュアなパスワードの実装メソッド
  has_secure_password
  # passwordのバリデーション
  validates :password, presence: true, length: { minimum: 6 }
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
