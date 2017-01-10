class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.belongs_to :category
      t.string :description
      t.boolean :front
      t.boolean :back
      t.integer :other_side_of_card_fk, index: true
      t.timestamps
    end
  end
end
