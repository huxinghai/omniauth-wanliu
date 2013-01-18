$:.unshift File.expand_path('../omniauth-wanliu', __FILE__)

require 'engine' if defined?(Rails)
require "version"
require 'helpers'
require 'sso'
require "wanliu_id"