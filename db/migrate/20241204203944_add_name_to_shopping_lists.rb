class AddNameToShoppingLists < ActiveRecord::Migration[7.2]
  def change
    add_column :shopping_lists, :name, :string
  end
end
