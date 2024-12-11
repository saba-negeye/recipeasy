class PagesController < ApplicationController
  def home
    if user_signed_in?
      @shopping_list = current_user.shopping_list
    end
end
end
