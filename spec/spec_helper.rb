require "json"
require "rspec"
require "http"
require "application_controller"

require File.expand_path("../../lib/omniauth-wanliu/sso", __FILE__)
OmniAuth::Wanliu.test_mode(true)
require File.expand_path("../../lib/omniauth-wanliu", __FILE__)

require 'ajax_auth_controller'
