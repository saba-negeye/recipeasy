class User < ApplicationRecord
  has_many :recipes
  has_one :shopping_list, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Create a shopping list when user is created
  #after_create :create_shopping_list

  private
  #method creates list 
  #def create_shopping_list
    #self.create_shopping_list(name: "My Shopping List")
  #end
end
