class Account::PaymentController < AccountController


    before_action :set_stripe_client, only: [:stripe_autorize, :stripe_callback]


    # --------------------------------------------------------------------------
    # ACTIONS
    # --------------------------------------------------------------------------

    def stripe_autorize

        @scope = 'read_write'
        @redirect_uri = 'http://localhost:3000/account/payment/stripe_callback'

        @authorize_url = @client.auth_code.authorize_url(:redirect_uri => @redirect_uri, :scope => @scope)
        redirect_to @authorize_url

    end

    # --------------------------------------------------------------------------

    def stripe_deautorize

        Stripe.api_key = "sk_test_1CvUPbpqWmqinhOT3QywbyGR00ca45wj1i"
        @client_id  = 'ca_GYOUPUcXR04B7o315RjKD5vbazFpNwwG' # Stripe Connect Application ID

        # Marketplace params
        account = Stripe::Account.retrieve(current_user.stripe_user_id)
        account.deauthorize(@client_id)

        current_user.stripe_user_id = nil
        current_user.stripe_publishable_key = nil
        current_user.save

        redirect_to account_settings_url
    end

    # --------------------------------------------------------------------------

    def stripe_callback

        # Pull the authorization_code out of the response
        code = params[:code]

         # Make a request to the access_token_uri endpoint to get an access_token
        @resp = @client.auth_code.get_token(code, :params => {:scope => 'read_write', :grant_type => 'authorization_code'})
        @access_token = @resp.token

        # Capture stripe_user_id
        stripe_user_id          = @resp.params["stripe_user_id"]
        stripe_publishable_key  = @resp.params["stripe_publishable_key"]

        current_user.stripe_user_id = stripe_user_id
        current_user.stripe_publishable_key = stripe_publishable_key
        current_user.save

        redirect_to account_settings_url
    end



    # --------------------------------------------------------------------------
    # PRIVATE
    # --------------------------------------------------------------------------

    private

    def set_stripe_client

        # Marketplace params
        @client_id  = 'ca_GYOUPUcXR04B7o315RjKD5vbazFpNwwG' # Stripe Connect Application ID
        @secret_key = 'sk_test_1CvUPbpqWmqinhOT3QywbyGR00ca45wj1i' # Stripe Marketplace Account secret KEY

        # Access Token Request to STRIPE
        options = {
          :site => 'https://connect.stripe.com/oauth/token',
        }

        @client = OAuth2::Client.new(@client_id, @secret_key, options )

    end


end
