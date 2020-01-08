class Account::DashboardController < AccountController

    # --------------------------------------------------------------------------
    # VIEWS
    # --------------------------------------------------------------------------

    def index
        @products = current_user.products.sort_by(&:total_sales).reverse!
    end

end
