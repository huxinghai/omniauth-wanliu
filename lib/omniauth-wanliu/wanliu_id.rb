require 'omniauth-oauth2'

module OmniAuth
    module Strategies
        class WanliuId < OmniAuth::Strategies::OAuth2

            # option :iframe, true

            server_addr = OmniAuth::Wanliu.config["provider_url"]

            # This is where you pass the options you would pass when
            # initializing your consumer from the OAuth gem.
            option :client_options, {
                :site => server_addr,
                :authorize_url => "#{server_addr}/auth/wanliu_id/authorize",
                :access_token_url => "#{server_addr}/auth/wanliu_id/access_token"
            }

            # These are called after authentication has succeeded. If
            # possible, you should try to set the UID without making
            # additional calls (if the user id is returned with the token
            # or as a URI parameter). This may not be possible with all
            # providers.
            uid{ raw_info['id'] }

            info do
            {
              :name => raw_info["info"]['name'],
              :email => raw_info["info"]['email']
            }
            end

            extra do
            {
              'raw_info' => raw_info
            }
            end

            def raw_info                
                @raw_info ||= access_token.get("/auth/wanliu_id/user.json?oauth_token=#{access_token.token}").parsed                
            end
        end
    end
end