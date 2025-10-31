class ChangeDayToIntegerInLists < ActiveRecord::Migration[7.1]
  def change
    change_column :lists, :day, :integer
  end
end
