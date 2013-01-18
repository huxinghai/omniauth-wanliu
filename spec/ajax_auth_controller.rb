class AjaxAuthController < ApplicationController    
    include OmniAuth::Wanliu::AjaxHelpers

    before_filter :login_required

    def index
    end

    private
    def login_required     
        if request.xhr?
            ajax_set_response_headers
        end
    end
end