class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :ensure_correct_user]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
      @articles = Article.select('articles.*').where.not(status: 'unpublished')
      @unpublishes = Article.joins(:user).select('articles.*').where(users: {id: session[:user_id]}).where(status: 'unpublished')
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to articles_url, notice:"「#{@article.title}」を投稿しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @article.update!(article_params)
    redirect_to articles_url, notice: "「#{@article.title}」を更新しました。"
  end

  def destroy
    @article.destroy
    redirect_to articles_url
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def ensure_correct_user
    unless @article.user_id == current_user.id
      redirect_to root_url, notice: "他のユーザーの投稿です"
    end
  end
  def article_params
    params.require(:article).permit(:title, :text, :status)
  end
end
