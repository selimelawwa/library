class AddTotalcostToOrder < ActiveRecord::Migration[5.1]
  def change
     add_column :orders, :total_cost, :decimal
  end
end
