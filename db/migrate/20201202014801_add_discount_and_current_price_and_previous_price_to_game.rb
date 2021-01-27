class AddDiscountAndCurrentPriceAndPreviousPriceToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :discount, :string
    add_column :games, :previous_price, :string
    add_column :games, :current_price, :string
  end
end
