class Card < ApplicationRecord
  belongs_to :category
  has_one :flip_side, class_name: "Card"

  validates :description, presence: true, length: { minimum: 1 }
  validates :category_id, presence: true

  def self.get_cards_by_category(category = nil)
    category.present? ? Card.where("category_id = ?", category) : Card.all
  end

  def self.get_review_cards(category)
    get_cards_by_category(category).where("front = true")
  end

  def self.save_cards(front, back)
    front.save
    back.flip_side_id = front.id
    back.save
    front.update!(flip_side_id: back.id)
  end

  def delete
    Card.destroy(self.flip_side_id)
    self.destroy
  end

  def keep_flip_category_in_sync
    Card.find(self.flip_side_id).update(category_id: self.category_id)
  end

  def update_streak(correct)
    correct == "true" ? self.streak += 1 : self.streak = 0
    self.save
    keep_streak_in_sync
  end

  def keep_streak_in_sync
    Card.find(self.flip_side_id).update(streak: self.streak)
  end
end
