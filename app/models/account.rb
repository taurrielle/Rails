class Account < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :transactions

  validates :name, presence: true
  validates :balance, presence: true
  validates :currency, presence: true
end
