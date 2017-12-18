class RemoveRatingFromBook < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :rating    
    remove_column :books, :floatrating    
  end
end
