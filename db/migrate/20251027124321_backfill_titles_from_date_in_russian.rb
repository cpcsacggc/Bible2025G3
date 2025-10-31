class BackfillTitlesFromDateInRussian < ActiveRecord::Migration[7.1]
  class List < ApplicationRecord
    self.table_name = "lists"
  end

  def up
    # make sure ru locale is available (config/locales/ru.yml) and loaded
    I18n.with_locale(:ru) do
      List.reset_column_information
      List.find_in_batches(batch_size: 1000) do |batch|
        List.transaction do
          batch.each do |rec|
            next unless rec.respond_to?(:date) && rec.date.present?
            # "%-d %B" => e.g. "1 января" (day + month name in Russian)
            russian_date = I18n.l(rec.date, format: "%-d %B", locale: :ru)
            rec.update_columns(title: "Чтение Библии на #{russian_date}:")
          end
        end
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
