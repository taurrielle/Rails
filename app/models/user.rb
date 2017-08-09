class User < ApplicationRecord
  has_many :accounts
  has_many :transactions

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
end
