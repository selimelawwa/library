class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :isbn
      t.string :author
      t.string :category
      t.string :language
      t.string :publisher
      t.string :image

      t.decimal :price
    
      t.timestamps
    end
  end
end
