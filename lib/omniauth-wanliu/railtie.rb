module OmniAuth
    module Wanliu
        class Railtie < Rails::Railtie
            initializer "configure file" do 
                OmniAuth::Wanliu.include_wanliu
            end
        end
    end
end