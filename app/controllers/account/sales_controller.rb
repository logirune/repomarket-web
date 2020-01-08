class Account::SalesController < AccountController

    # --------------------------------------------------------------------------
    # VIEWS
    # --------------------------------------------------------------------------

    def index
        @orders = Order.where(author_id: current_user.id).order('created_at DESC')
    end

    # --------------------------------------------------------------------------

    def view
        @order = Order.find(params[:id])
    end

end
