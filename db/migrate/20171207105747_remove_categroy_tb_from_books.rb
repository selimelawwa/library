class RemoveCategroyTbFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :category    
  end
end
