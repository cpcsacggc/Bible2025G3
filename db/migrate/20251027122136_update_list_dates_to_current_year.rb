class UpdateListDatesToCurrentYear < ActiveRecord::Migration[7.1]
  def up
    current_year = Date.current.year
    List.find_each do |list|
      if list.date.present?
        # Replace only the year part, keep month and day
        new_date = list.date.change(year: current_year)
        list.update_columns(date: new_date)
      end
  end
  end

  def down
    # Optional: You can’t easily revert this unless you stored previous years
    Rails.logger.info "No rollback for UpdateListDatesToCurrentYear"
  end
  end