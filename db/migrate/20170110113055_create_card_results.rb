class CreateCardResults < ActiveRecord::Migration[5.0]
  def change
    create_table :card_results do |t|
      t.belongs_to :card
      t.integer :consecutive_correct_answers
      t.timestamps
    end
  end
end
