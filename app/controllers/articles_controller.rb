class ArticlesController < ApplicationController
  before_action :set_article, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :is_admin!, except: [:index, :show]

  def index
    @articles=Article.order(created_at: :DESC)
  end

  def new
    # @article = Article.new
    @article = current_user.articles.build

  end
  
  def create
    # @article = Article.new(params[:article])
    # @article = Article.new(article_params)
    
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = "Article successfully created"
      redirect_to @article
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  def show
    @article=Article.find(params[:id])
  end

  def edit
    @article= Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end


  # def correct_user
  #   @article = current_user.articles.find_by(params[:id])
  #   # @article = current_user.articles.find(params[:id])

  #   redirect_to articles_path, notice: "Not authorized to Edit this Article !" if @article.nil?
  # end

  private

  def set_article
    @article= Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,:body, :user_id)
  end

end
