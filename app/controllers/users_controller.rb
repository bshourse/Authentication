class UsersController < ApplicationController

   before_action :login_user_to_index, except: [:show]

  def new
    @user = User.new
  end
  private def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

   def show
     @user = User.find(session[:user_id])
   end

end
