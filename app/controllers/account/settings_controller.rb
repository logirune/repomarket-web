class Account::SettingsController < AccountController

    before_action :authenticate_user!

    # --------------------------------------------------------------------------
    # VIEWS
    # --------------------------------------------------------------------------

    def index
        client = Octokit::Client.new(:client_id => '19d958a07a642e0bc81d', :client_secret => '17e9c1ecc71617a8d8cee859ff247b59c17cc0a8')
        @github_token_validity = client.check_application_authorization(current_user.github_token) unless current_user.github_token.nil?
    end

    # --------------------------------------------------------------------------

    # --------------------------------------------------------------------------
    # ACTIONS
    # --------------------------------------------------------------------------

    def github_autorize
        if current_user.github_token.nil?
            redirect_to user_github_omniauth_authorize_url
        else
            redirect_to account_settings_url
        end
    end

    def github_deautorize

        unless current_user.github_token.nil?

            begin
                client = Octokit::Client.new(:client_id => '19d958a07a642e0bc81d', :client_secret => '17e9c1ecc71617a8d8cee859ff247b59c17cc0a8')
                client.revoke_application_authorization(current_user.github_token)

                current_user.github_token = nil
                current_user.save

                redirect_to account_settings_url

            rescue Octokit::Error => e
                puts "####################################################"
                puts e.inspect
                puts "####################################################"
            end


        else
            redirect_to account_settings_url
        end

    end

    # --------------------------------------------------------------------------
    # REMOTE
    # --------------------------------------------------------------------------

    # --------------------------------------------------------------------------
    # PRIVATE
    # --------------------------------------------------------------------------

end
