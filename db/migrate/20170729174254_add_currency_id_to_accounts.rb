class AddCurrencyIdToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :currency_id, :integer
  end
end
