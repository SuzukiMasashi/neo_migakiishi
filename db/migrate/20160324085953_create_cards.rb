class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :code
      t.integer :cost
      t.string :name
      t.integer :card_class
      t.integer :card_set
      t.integer :card_type
      t.integer :race
      t.integer :rarity
      t.boolean :collectible
      t.string :card_text
      t.integer :attack
      t.integer :health
      t.integer :durability

      t.timestamps null: false
    end
    add_index :cards, :code, unique: true
  end
end
