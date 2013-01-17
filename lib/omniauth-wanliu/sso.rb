module OmniAuth
	module Wanliu
		def self.config
			path = "../../config/sso.yaml"
			File.file?(path) ?  YAML::load_file(path)[:accounts] : raise "not exists config/sso.yml file ?"
		end
	end
end