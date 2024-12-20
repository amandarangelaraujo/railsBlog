class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :set_user, only: [:new, :create]
  load_and_authorize_resource

  # GET /articles or /articles.json
  def index
    @articles = Article.order(created_at: :desc)
    if logged_in?
      @user = current_user
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    if logged_in?
      @user = current_user
    end

    
  end

  # GET /articles/1/edit
  def edit
    @user = current_user
  end

  # POST /articles or /articles.json
  def create
    @user = current_user
    @article = @user.articles.build(article_params)
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else

        format.html { render :new, status: :unprocessable_entity, notice: "Article was not created"}
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_path, status: :see_other, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :user_id, :photo)
    end
end
