class AddRatersToBooks < ActiveRecord::Migration[5.1]
  def change
     add_column :books, :raters, :integer, :default => 1
  end
end
