class List < ApplicationRecord
  validates :day, :date, :msg, :title, presence: true
  validates :day, numericality: { greater_than_or_equal_to: 1 }
  validates :day, numericality: { less_than_or_equal_to: 365 }
  validates :day, uniqueness: true
  validates :date, uniqueness: true
end
