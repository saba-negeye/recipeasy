class User < ApplicationRecord
  has_many :recipes
  has_one :shopping_list, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
 
  after_create :create_shopping_list

  private
  def create_shopping_list
    ShoppingList.create(name: "My Shopping List", user:self)
  end
end
