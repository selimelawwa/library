class RemoveUserSecondtime < ActiveRecord::Migration[5.1]
  def change
    drop_table(:user_secondtimes)
  end
end
