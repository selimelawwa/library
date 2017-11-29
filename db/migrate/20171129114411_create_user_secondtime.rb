class CreateUserSecondtime < ActiveRecord::Migration[5.1]
  def change
    create_table :user_secondtimes do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :telephone
      t.string :fname
      t.string :lname

      t.boolean :admin, default: false
      t.timestamps
    end
  end
end
