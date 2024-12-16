class SessionsController < ApplicationController
  #para entrar em uma sessão no sistema

  def new
    #apenas exibir o formulário
  end

  def create
    user = User.find_by(email: params[:email]) 
    if user&.authenticate(params[:password]) 
      session[:user_id] = user.id # Armazena o ID do usuário na sessão
      redirect_to articles_path, notice: "Login realizado com sucesso!"
    else
      flash.now[:alert] = "Email ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end

  #logout
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logout realizado com sucesso!"
  end
end
