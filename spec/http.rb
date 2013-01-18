class Response
    attr_accessor :headers

    def initialize
        @headers =  {}
    end
end

class Request
    attr_accessor :env

    def initialize
        @env = {"HTTP_HOST" => "localhost:3002"}
    end

    def xhr?
        true
    end
end