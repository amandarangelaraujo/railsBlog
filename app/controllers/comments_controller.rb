class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  # GET /comments/1 or /comments/1.json
  def show
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  # GET /comments/new
  def new
    #deixar esse id provisório
    @user = 1
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build

  end

  # GET /comments/1/edit
  def edit
    @article = Article.find(params[:article_id])
  
  end

  # POST /comments or /comments.json
  def create
    @user = User.find(1)
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = @user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @article, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
  
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_path, status: :see_other, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :name, :comment ])
    end
end
