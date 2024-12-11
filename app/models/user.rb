class User < ApplicationRecord
  has_many :recipes
  has_one :shopping_list, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
   validates :first_name, presence: true      
 
  after_create :create_shopping_list
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
  private
  def create_shopping_list
    ShoppingList.create(name: "My Shopping List", user:self)
  end
end
