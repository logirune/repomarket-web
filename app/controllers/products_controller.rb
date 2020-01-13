class ProductsController < ApplicationController

    before_action :authenticate_user!, only: [:buy,:download]
    before_action :set_product , only: [:show, :buy, :download, :register_download]
    before_action :check_product , only: [:show, :buy, :download]

    # --------------------------------------------------------------------------
    # VIEWS
    # --------------------------------------------------------------------------

    def explore

        # Récupération du language ( RUBY )
        session[:language] = 'all'
        session[:language_name] = 'All languages'

        session[:framework] = 'all'
        session[:framework_name] = "All frameworks"

        session[:category] = "all"
        session[:category_name] = "All categories"

        @languages       = Language.all
        @frameworks      = nil
        @categories      = Category.all
        @products        = Product.from_active_users.all

        if params.has_key?(:language) && !params[:language].nil?
            if params[:language] != 'all'
                @language = Language.where(slug: params[:language]).first
                @products = @products.where(language_id: @language.id)
                session[:language] = @language.slug
                session[:language_name] = @language.name

                @frameworks = Framework.where(language_id: @language.id)
            end
        end

        if params.has_key?(:framework) && !params[:framework].nil?
            if params[:framework] != 'all' && params[:framework] != 'none'
                @framework = Framework.where(slug: params[:framework]).first
                @products = @products.where(framework_id: @framework.id)
                session[:framework] = @framework.slug
                session[:framework_name] = @framework.name
            end
            if params[:framework] == 'none'
                @products = @products.where(framework_id: nil)
                session[:framework] = "none"
                session[:framework_name] = "No framework"
            end
        end

        if params.has_key?(:category) && !params[:category].nil?
            if params[:category] != 'all' &&  params[:category] != 'none'
                @category = Category.where(slug: params[:category]).first
                @products = @products.where(category_id: @category.id)
                session[:category]      = @category.slug
                session[:category_name] = @category.name
            end
            if params[:category] == 'none'
                @products = @products.where(category_id: nil)
                session[:category]      = 'none'
                session[:category_name] = "Uncategorized"
            end
        end

        if params.has_key?(:search) && !params[:search].empty?
            @products = @products.search(params[:search].downcase)
            @search = true
        end

    end

    # --------------------------------------------------------------------------

    def show
        if params[:id].nil?
            redirect_to explore_category_url
        else
            @products = @product.user.products.with_attached_screenshots.last(2)
            register_view
        end
    end

    # --------------------------------------------------------------------------

    def buy
        if @product.price == 0
            redirect_to product_download_url
        else
            register_checkout
        end
    end

    # --------------------------------------------------------------------------

    def download
        if @product.price == 0
            @archive_link = Octokit.archive_link(@product.github_repo_id.to_i)
            register_download
        end
    end

    # --------------------------------------------------------------------------
    # ACTIONS
    # --------------------------------------------------------------------------

    # --------------------------------------------------------------------------
    # REMOTE
    # --------------------------------------------------------------------------

    def register_download
        unless @product.nil? || user_signed_in? && @product.user_id == current_user.id
            @product.increment!(:downloads_count,1)
        end
    end

    # --------------------------------------------------------------------------
    # PRIVATE
    # --------------------------------------------------------------------------

    private

    def check_product
        if @product.nil?
            redirect_to explore_url(language: session[:language], language: session[:language], category: session[:category]), alert: 'Product not found'
        end
    end

    # --------------------------------------------------------------------------

    def set_product
        begin
            @product = Product.from_active_users.find_by_id(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            redirect_to explore_url, alert: 'Product not found'
        end
    end

    # --------------------------------------------------------------------------

    def register_view
        unless @product.nil? || user_signed_in? && @product.user_id == current_user.id
            @product.increment!(:views_count,1)
        end
    end

    # --------------------------------------------------------------------------

    def register_checkout
        unless @product.nil? || user_signed_in? && @product.user_id == current_user.id
            @product.increment!(:checkouts_count,1)
        end
    end

end
