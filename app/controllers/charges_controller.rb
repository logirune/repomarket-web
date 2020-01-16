class ChargesController < ApplicationController

    before_action :authenticate_user!

    # --------------------------------------------------------------------------
    # VIEWS
    # --------------------------------------------------------------------------

    def error
    end

    # --------------------------------------------------------------------------
    # ACTIONS
    # --------------------------------------------------------------------------

    def create

        Stripe.api_key = "sk_test_1CvUPbpqWmqinhOT3QywbyGR00ca45wj1i"

        @product = Product.find_by_id(params[:id])
        @author = @product.user

        unless !@author.stripe_user_id.nil?
            return render :error
        end

        # PREPARATION DES INFORMATIONS
        @fee                = 20
        #@grand_total        = (@product.price + (@product.price * (5.0/100) + @product.price * (9.975/100)).round(2))
        @amount             = @product.price
        @fees_amount        = ((@amount * @fee ) / 100)
        @net_amount         = @amount - @fees_amount


        # Formatage du prix pour Stripe
        @stripe_amount = @amount * 100
        @stripe_amount = @stripe_amount.to_i

        # Calcul du pourcentage
        @stripe_fees_amount    = ((@stripe_amount * @fee ) / 100)
        # Recevoir les parametres de paiement
        # Récupérer les informations de l'auteur du code
        # Effectuer le paiement avec STRIPE
        # Enregistrer le retour de stripe l'achat dans la table Orders
        # Proposer le téléchargement

        # Get the credit card details submitted by the form
        token = params[:stripeToken]
        email = params[:stripeEmail]

        charge = Stripe::Charge.create({
          :amount => @stripe_amount, # amount in cents
          :currency => "cad",
          :source => token,
          :description => @product.title,
          :application_fee => @stripe_fees_amount,
          :destination => @author.stripe_user_id,
          :receipt_email => email,
        })

        @stripe_charge_response = charge

        # UPDATE ORDER

        if charge['status'] == "succeeded"

            # ENREGISTREMENT DE LA COMMANDE

            @customer = current_user
            @order = current_user.orders.create({
                product_id: @product.id,
                amount: @amount,
                net_amount: @net_amount,
                fees_amount: @fees_amount,
                fee_percentage: @fee,
                author_id: @author.id,
                product_name: @product.title
            })

            @order.stripe_response_data = @stripe_charge_response

            # Enregistrement du fichier dans la commande

            unless @product.user.github_token.nil?
                Octokit.configure do |c|
                    c.access_token = @product.user.github_token
                end

                # Récupération de l'utilisateur
                @archive_link = Octokit.archive_link(@product.user.github_login+"/"+@product.github_repo_name)

                require 'open-uri'
                download = open(@archive_link)
                @order.digital_product.attach(io: download, filename: @product.github_repo_name + '.tar.gz' )
            end

            @order.save
            @product.increment!(:purchases_count,1)
        end

        # Redirection vers la page d'achat

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to product_buy_path(@product.slug)
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
