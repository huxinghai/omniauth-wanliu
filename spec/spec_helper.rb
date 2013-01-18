require "json"
require "rspec"
require "http"
require "example_application_controller"

require File.expand_path("../../lib/omniauth-wanliu/sso", __FILE__)
OmniAuth::Wanliu.test_mode(true)
OmniAuth::Wanliu.include_wanliu
require File.expand_path("../../lib/omniauth-wanliu", __FILE__)

require 'ajax_auth_controller'
