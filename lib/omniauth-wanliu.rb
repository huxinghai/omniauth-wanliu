$:.unshift File.expand_path('../omniauth-wanliu', __FILE__)

require "version"
require 'helpers'
require 'sso'

if defined?(Rails)
    require 'engine'
    require 'railtie'
end 