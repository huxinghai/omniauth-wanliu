class ApplicationController     
    attr_accessor :session, :response, :request

    def initialize
        @session = {}
        @response = Response.new
        @request = Request.new
    end

    def self.before_filter(*args)
        @@filter_methods ||= []
        @@filter_methods << args.first
    end

    def self.get(path)
        _klass = new
        @@filter_methods.each do | method |            
            _klass.send(method)
        end
        _klass
    end
end