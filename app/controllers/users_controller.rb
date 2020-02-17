class UsersController < ApplicationController

   before_action :login_user_to_index, except: [:show, :edit, :update]
   before_action :require_user, except: [:new] # Выдавать неавторизованному пользователю страницу с логином, исключение переход на страницу с регистрацией. Делаю это для того чтобы не падала ошибка при попытке неавторизаванного пользователя перейти по ссылке /profile (в контроллере метод show)

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

   def update
     @user = User.find(session[:user_id])
     if @user.update_attributes(user_params)
       redirect_to(:action => 'show', :id => @user.id)
       else render 'edit'
     end
   end

   def edit
     @user = User.find(session[:user_id])
   end
end
