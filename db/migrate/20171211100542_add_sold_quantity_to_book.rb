class AddSoldQuantityToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :ordered_times, :integer
  end
end
