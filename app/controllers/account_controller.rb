class AccountController < ApplicationController

    before_action :authenticate_user!

    # --------------------------------------------------------------------------
    # VIEWS
    # --------------------------------------------------------------------------

    # --------------------------------------------------------------------------
    # ACTIONS
    # --------------------------------------------------------------------------

	# --------------------------------------------------------------------------
    # PRIVATE
    # --------------------------------------------------------------------------


    def my_function
        @languages = language.all

        redirect_to root_url
        
    end



end
