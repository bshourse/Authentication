class ApplicationController < ActionController::Base
  helper_method :current_user # Строка helper_method: current_user делает метод current_user доступным во вьюхах.

  def current_user # Метод current_user определяет, вошел ли пользователь в систему или вышел из нее. Это делается путем проверки наличия пользователя в базе данных с данным идентификатором сеанса. Если есть, это означает, что пользователь вошел в систему, и @current_user сохранит этого пользователя; в противном случае пользователь вышел из системы, и @current_user будет иметь значение nil.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user # Метод require_user использует метод current_user для перенаправления вышедших из системы пользователей на страницу входа.
    redirect_to '/login' unless current_user
  end

  def require_author # Аналогично метод require_author должен использовать метод current_user, чтобы проверить, является ли пользователь автором, и перенаправить на корневой путь, если он / она не является.
    redirect_to '/' unless current_user.author?
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

end