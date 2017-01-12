class Card < ApplicationRecord
  belongs_to :category
  validates :description, presence: true, length: { minimum: 1 }
  validates :category_id, presence: true
end
