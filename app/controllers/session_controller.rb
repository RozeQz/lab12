class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[login create]

  def login; end

  def create
    user = User.find_by username: params[:username]

    # Метод authenticate автоматически добавляется с помощью has_secure_password. 
    # Внутри себя он хэширует переданные ему параметры и сравнимавает это с
    # содержимым в базе данных.
    if user&.authenticate(params[:password])
      p 'LOGIN'
      sign_in user
      redirect_to root_path
    else
      p 'REDIRECT'
      flash[:danger] = 'Incorrect login and/or password'
      redirect_to session_login_path
    end
  end

  def logout
    sign_out
    redirect_to session_login_path
  end
end
