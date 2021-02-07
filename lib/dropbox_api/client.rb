# frozen_string_literal: true
module DropboxApi
  class Client
    def initialize(oauth_bearer = ENV['DROPBOX_OAUTH_BEARER'])
      @connection_builder = ConnectionBuilder.new(oauth_bearer)
    end

    def middleware
      @connection_builder.middleware
    end

    # @!visibility private
    def self.add_endpoint(name, endpoint)
      define_method(name) do |*args, &block|
        endpoint.new(@connection_builder).send(name, *args, &block)
      end
    end
  end
end
