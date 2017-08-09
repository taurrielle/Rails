class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :user

  validates :ammount,      presence: true
  validates :description,  presence: true
  validates :made_on_date, presence: true
  validates :account,      presence: true
end
