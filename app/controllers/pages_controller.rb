class PagesController < ApplicationController

    # --------------------------------------------------------------------------
    # VIEWS
    # --------------------------------------------------------------------------

    def index

        @languages      = Language.order('created_at ASC').last(5)
        @frameworks     = Framework.order('created_at ASC').last(5)
        @categories     = Category.order('created_at ASC').last(5)

        if params.has_key?(:search) && !params[:search].empty? || params.has_key?(:product_type) && !params[:product_type].empty?
            @products = Product.from_active_users.with_valid_products.search(params[:search].downcase)
            @search = true
        else
            @products = Product.from_active_users.with_valid_products.includes(:language, :framework, :category).with_attached_screenshots.last(6)
        end
    end

    # --------------------------------------------------------------------------

    def about
    end

    # --------------------------------------------------------------------------

    def faq
    end

    # --------------------------------------------------------------------------

    def onboard_seller
    end

    # --------------------------------------------------------------------------

    def privacy_policies
    end

    # --------------------------------------------------------------------------

    def terms_of_services
    end

    # --------------------------------------------------------------------------
    # ACTIONS
    # --------------------------------------------------------------------------


    # --------------------------------------------------------------------------
    # REMOTE
    # --------------------------------------------------------------------------


    # --------------------------------------------------------------------------
    # PRIVATE
    # --------------------------------------------------------------------------

end
