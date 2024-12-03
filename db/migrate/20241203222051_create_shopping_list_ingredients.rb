class CreateShoppingListIngredients < ActiveRecord::Migration[7.2]
  def change
    create_table :shopping_list_ingredients do |t|
      t.references :shopping_list, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
