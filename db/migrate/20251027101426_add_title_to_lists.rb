class AddTitleToLists < ActiveRecord::Migration[7.1]
  def up
    add_column :lists, :title, :text
    say_with_time "Backfilling lists.title" do
      execute <<~SQL.squish
        UPDATE lists
        SET title = CAST(lists.day AS TEXT)
        WHERE day IS NOT NULL and title IS NULL;
      SQL
    end
    change_column_null :lists, :title, false
  end
  def down
    change_column_null :lists, :title, true
    remove_column :lists, :title, :text
  end
end
