require "spec_helper"

describe OmniAuth::Strategies::WanliuId do 
    let(:access_token){ stub('AccessToken', :options => {}) }

    before :each do 
        @config = OmniAuth::Wanliu.config
    end

    subject do         
        OmniAuth::Strategies::WanliuId.new(
            :client_id => @config["app_id"], 
            :client_secret => @config["app_secret"]
        )
    end

    context "test omniauth wanliu client options" do 

        it "should have correct site name" do 
            subject.name.should eq("wanliuid")
        end

        it "should have correct site address" do 
            subject.client.site.should eq(@config['provider_url'])
        end

        it "should have correct authorize url" do 
            subject.client.options[:authorize_url].should eq("#{@config['provider_url']}/auth/wanliu_id/authorize")            
        end

        it "should have correct access token url" do 
            subject.client.options[:access_token_url].should eq("#{@config['provider_url']}/auth/wanliu_id/access_token")
        end
    end

    context "test omniauth raw_info" do 
        before :each do 
            subject.stub!(:access_token).and_return(access_token)
            @data = {
                "id" => "123",
                "provider" => "wanliu_id",
                "info" => {
                    "email" => "test@gmail.com", 
                    "name" => "test_name",
                    "login" => "test",
                    "telephone" => "15813146160"
                }                
            }

            subject.stub!(:raw_info).and_return(@data)
        end

        it "should have correct raw info" do 
            subject.raw_info.should eq(@data)
        end

        it "should have correct uid" do 
            subject.uid.should eq(@data["id"])
        end

        it "should have correct user info" do             
            subject.info[:email].should eq(@data["info"]["email"])
            subject.info[:name].should eq(@data["info"]["name"])
        end        
    end

    context "test omniauth ajax request" do 

        before :each do 
            @controller = AjaxAuthController.get("/ajaxauth/index")
            @auth_params = @controller.auth_params
        end
        
        it "should have correct headers info " do 
            headers = @controller.response.headers               
            headers["sso_auth_url"].should eq(subject.client.options[:authorize_url])
            headers["sso_auth_params"].should eq(@auth_params.to_json)            
        end

        it "should have correct foreg omniauth validate state" do 
            @controller.session["omniauth.state"].should eq(@auth_params[:state])
        end

        it "should have correct app id " do             
            @auth_params[:client_id].should eq(OmniAuth::Wanliu.config["app_id"])
        end
    end
end