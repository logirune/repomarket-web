class Account::ProfileController < AccountController

    # --------------------------------------------------------------------------
    # VIEWS
    # --------------------------------------------------------------------------

    def index
        @user = current_user
    end

    # --------------------------------------------------------------------------
    # ACTIONS
    # --------------------------------------------------------------------------

    def update
        if current_user.update(user_params)
            redirect_to account_profile_url, notice: 'Your profile has been successfully updated.'
        else
            redirect_to account_profile_url, alert: 'First name and an email are required'
        end
    end

    # --------------------------------------------------------------------------
    # PRIVATE
    # --------------------------------------------------------------------------

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :company_name, :email)
    end

end
