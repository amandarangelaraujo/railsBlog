class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy edit_user_type update_user_type ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  def admin
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    if User.email_in_use?(user_params[:email])
      redirect_to new_user_path, alert: "Este email já está sendo utilizado."
    else
      @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          format.html { redirect_to login_path, notice: "Usuário cadastrado com sucesso, faça login" }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # PATCH/PUT /users/1 or /users/1.json
  def update
    if User.email_in_use?(user_params[:email])
      redirect_to new_user_path, alert: "Este email já está sendo utilizado."
    else
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end # Fecha o else
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to admin_users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET
  def edit_user_type
    @user = User.find(params[:id])
    render "users/edit_user_type"
  end

  # PATCH/PUT /users/:id/update_user_type
  def update_user_type
    if @user.update(user_type_params)
      redirect_to admin_users_path, notice: "Tipo de usuário atualizado com sucesso."
    else
      render :edit_user_type, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:user_type, :name, :email, :password,  :password_confirmation)
    end

    #Para a função de editar o tipo de usuário
    def user_type_params
      params.require(:user).permit(:user_type)
    end

  
end
