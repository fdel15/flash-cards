class Category < ApplicationRecord
  has_many :cards
  validates :description, presence: true, length: { minimum: 1 }
end
