class Account < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one :currency, :foreign_key => "currency_id"
  # default_scope -> { order(created_at: :desc) }
  
  #validates :user_id, presence: true
  validates :name, presence: true
  validates :balance, presence: true
  # validates :currency, presence: true
end
