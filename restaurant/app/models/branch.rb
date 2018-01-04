class Branch < ApplicationRecord
  # validations
  validates :name, :opening_time, :closing_time, presence: true
  validates :name, uniqueness: true
  validate :validate_timings, if: (:opening_time? && :closing_time?)

  # assosciations
  has_many :inventories, dependent: :destroy
  has_many :ingredients, through: :inventories

  def validate_timings
    errors.add(:opening_time, "should be before closing time") if closing_time < opening_time
  end
end
