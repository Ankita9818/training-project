class Ingredient < ApplicationRecord

  # validation
  validates :name, :price, presence: true
  validate :validate_price, if: :price?
  validates :category, inclusion: [true, false]

  private
    def validate_price
      errors.add(:price, 'Should be positive') if price < 0
    end
end
