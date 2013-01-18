module OmniAuth
    module Wanliu
        def self.config
            path = test_mode ?  "../../../spec/config/sso.yml" : "../../../config/sso.yml"
            full_path = File.expand_path(path, __FILE__)            
            File.file?(full_path) ?  YAML::load_file(full_path)["accounts"] : raise("not exists #{full_path} file ?")
        end

        def self.test_mode(state = nil)
            @test_model = state unless state.nil?
            @test_model
        end
    end
end