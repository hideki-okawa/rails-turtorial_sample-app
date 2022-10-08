class Micropost < ApplicationRecord
  # ユーザーと多対1の関係
  belongs_to :user
  # default_scope→データベースから要素を取得したときのデフォルトの順番を指定する
  # created_atの逆順にする
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
