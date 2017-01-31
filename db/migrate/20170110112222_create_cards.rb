class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.belongs_to :category, null: false
      t.string :description, null: false
      t.boolean :front, default: false
      t.boolean :back, default: false
      t.references :flip_side, index: true
      t.integer :streak, default: 0
      t.timestamps
    end
  end
end
