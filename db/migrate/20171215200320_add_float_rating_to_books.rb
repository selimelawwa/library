class AddFloatRatingToBooks < ActiveRecord::Migration[5.1]
  def change
     add_column :books, :floatrating, :integer, :default => 3.0
  end
end
