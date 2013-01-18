module OmniAuth
    module Wanliu
        def self.config
            path = File.expand_path("../../../config/sso.yaml", __FILE__)            
            File.file?(path) ?  YAML::load_file(path)["accounts"] : raise("not exists config/sso.yml file ?")
        end
    end
end