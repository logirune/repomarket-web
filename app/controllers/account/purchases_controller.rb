class Account::PurchasesController < AccountController

    before_action :set_order, only: [:view,:receipt]

    # --------------------------------------------------------------------------
    # VIEWS
    # --------------------------------------------------------------------------

    def index
        @orders = current_user.orders
    end

    # --------------------------------------------------------------------------

    def view
    end

    # --------------------------------------------------------------------------

    def receipt
        respond_to do |format|
            format.pdf do
                render pdf: "codemarket_receipt_order",
                template: "account/purchases/receipt.html.erb",
                disposition: "attachment",
                layout: "pdf.html.erb"
            end
        end
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

    private

    def set_order
        @order = Order.find(params[:id])
        @product = Product.with_deleted.find(@order.product_id)
    end

end
