class SessionsController < ApplicationController

  def new

  end

  def create # тут обрабатываем входящий пост запрос при авторизации пользователя. Находим юзера по email. Если находим, то ридерктим на главную страницу. В противном случае редиректим на /login
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to 'login'
    end
  end

  def destroy # тут мы обрабатываем delete запрос, когда пользователь делает logout. Путём установки хёша сессии пользователя в nil и последующим редиректом в root дерикторию
    session[:user_id] = nil
    redirect_to '/'
  end

end
