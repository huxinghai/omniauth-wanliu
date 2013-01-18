$:.unshift File.expand_path('../../omniauth-wanliu', __FILE__)

module OmniAuth
    module Wanliu
        def self.config            
            path = if test_mode                  
                File.expand_path("../../../spec/config/sso.yml", __FILE__)  
            else                
                defined?(Rails) ? Rails.root.join("config", "sso.yml") : OmniAuth::Wanliu.config_file
            end     
            raise "not config/sso.yml file?" if path.nil?            
            File.file?(path) ?  YAML::load_file(path)["accounts"] : raise("not exists #{path} file ?")
        end

        def self.test_mode(state = nil)
            @test_model = state unless state.nil?
            @test_model
        end

        def self.config_file(path = nil)
            @path = path unless path.nil?
            @path
        end

        def self.include_wanliu
            require "wanliu_id"
        end
    end
end