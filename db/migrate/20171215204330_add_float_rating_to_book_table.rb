class AddFloatRatingToBookTable < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :rating, :decimal, :default => 3.0
  end
end
