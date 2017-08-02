class Account < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :name, presence: true
  validates :balance, presence: true
  validates :currency, presence: true
end
