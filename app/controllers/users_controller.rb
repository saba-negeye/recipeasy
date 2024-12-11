class UsersController < ApplicationController
    before_action :authenticate_user! # Ensures users are logged in for all crud functions 
    
  

    def index
      @users = User.all
    end
  
   
    def show
        @user = User.find(params[:id])
    end
  
    
    def new
      @user = User.new
    end
  
 
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to @user, notice: 'User created successfully!'
      else
        render :new
      end
    end
  
    
    def edit
    end
  
   
    def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User updated successfully!'
      else
        render :edit
      end
    end
  

    def destroy
      @user.destroy
      redirect_to users_path, notice: 'User deleted successfully!'
    end
  
    private
  

    # Strong parameters 
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation) 
    end

  end
  