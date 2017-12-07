class DropBookCategories < ActiveRecord::Migration[5.1]
  def change
    drop_table(:book_categories)
  end
end
