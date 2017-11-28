class AddTotalCostToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :total_cost, :decimal
  end
end
