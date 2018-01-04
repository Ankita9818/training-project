class Comment < ApplicationRecord

  # assosciations
  belongs_to :user
  belongs_to :inventory

  # validations
  validates :body, presence: true
end
