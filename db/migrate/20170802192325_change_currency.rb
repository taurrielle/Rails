class ChangeCurrency < ActiveRecord::Migration[5.1]
  def change
    remove_column :accounts, :currency_id
    add_column :accounts, :currency, :string

  end
end
