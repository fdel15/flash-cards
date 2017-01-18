class Card < ApplicationRecord
  belongs_to :category
  has_one :flip_side, class_name: "Card"

  validates :description, presence: true, length: { minimum: 1 }
  validates :category_id, presence: true

  def flip_side_description
    Card.find(self.flip_side_id).description
  end

  def keep_flip_category_in_sync
    Card.find(self.flip_side_id).update(category_id: self.category_id)
  end
end
