class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    if params[:display] == "all"
      @articles = Article.all
    elsif params[:display] == "archived"
      @articles = Article.archived
    else
      @articles = Article.active
    end
    @active_count = Article.active.count
    @total_count = Article.all.count
  end

  # GET /articles/1 or /articles/1.json
  def show
    @record = Article.find(params[:id])
    @next_record = Article.where("id > ?", @record.id).order(:id).active.first
    @previous_record = Article.where("id < ?", @record.id).order(:id).active.last
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created" }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated", status: :see_other }
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
      format.html { redirect_to articles_path, notice: "Article was successfully deleted", status: :see_other }
      format.json { head :no_content }
    end
  end

  def set_archived
    @article = Article.find(params[:id]) # Make sure you find the article first!
    @article.update_column(:archived, true)
    redirect_to articles_path, notice: "Article was successfully archived"
  end

  def set_unarchived
    @article = Article.find(params[:id])
    @article.update_column(:archived, false)
    redirect_to articles_path, notice: "Article was successfully unarchived"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
