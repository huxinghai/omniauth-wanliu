module OmniAuth
    module Wanliu
        def self.config            
            path = if test_mode                  
                File.expand_path("../../../spec/config/sso.yml", __FILE__)  
            else
                Rails.root.join("config", "sso.yml")
            end     
            File.file?(path) ?  YAML::load_file(path)["accounts"] : raise("not exists #{path} file ?")
        end

        def self.test_mode(state = nil)
            @test_model = state unless state.nil?
            @test_model
        end
    end
end